module "vpc" {
  source = "../../../modules/vpc"

  cluster_name   = "${var.cluster_name}"
  vpc_region     = "${var.vpc_region}"
  vpc_name       = "${var.vpc_name}"
  vpc_cidr_block = "${var.vpc_cidr_block}"
}

module "subnet_public" {
  source = "../../../modules/subnet_public"

  cluster_name   = "${var.cluster_name}"
  vpc_id      = "${module.vpc.id}"
  vpc_region  = "${module.vpc.region}"
  subnet_name = "${var.subnet_public}"
  subnet_cidr = "${var.subnet_public_cidr}"
  subnet_az   = "${var.subnet_public_az}"
}

module "subnet_private_01" {
  source = "../../../modules/subnet_private"

  cluster_name   = "${var.cluster_name}"
  vpc_id      = "${module.vpc.id}"
  vpc_region  = "${module.vpc.region}"
  subnet_cidr = "${var.subnet_private_01_cidr}"
  subnet_name = "${var.subnet_private_01}"
  subnet_az   = "${var.subnet_private_01_az}"
}

module "security_groups" {
  source = "../../../modules/security_group"

  cluster_name = "${var.cluster_name}"
  vpc_id      = "${module.vpc.id}"
}

module "iam" {
  source = "../../../modules/iam"

}

resource "aws_eks_cluster" "demo" {
  name     = "${var.cluster_name}"
  role_arn = "${module.iam.iam_role_arn_cluster}"

  vpc_config {
    security_group_ids = ["${module.security_groups.demo-cluster_id}"]
    subnet_ids         = ["${module.subnet_public.id}","${module.subnet_private_01.id}"]
  }

  # depends_on = [
  #   "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy",
  #   "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSServicePolicy",
  # ]
}

data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.demo.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  demo-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.demo.endpoint}' --b64-cluster-ca '${aws_eks_cluster.demo.certificate_authority.0.data}' '${var.cluster_name}'
USERDATA
}


resource "aws_launch_configuration" "demo" {
  associate_public_ip_address = true
  iam_instance_profile        = "${module.iam.instance_profile_name}"
  image_id                    = "${data.aws_ami.eks-worker.id}"
  instance_type               = "t2.micro"
  name_prefix                 = "terraform-eks-demo"
  security_groups             = ["${module.security_groups.demo-node_id}"]
  user_data_base64            = "${base64encode(local.demo-node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "demo" {
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.demo.id}"
  max_size             = 2
  min_size             = 1
  name                 = "terraform-eks-demo"
  vpc_zone_identifier  = ["${module.subnet_private_01.id}"]

  tag {
    key                 = "Name"
    value               = "terraform-eks-demo"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}