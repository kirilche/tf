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

# resource "aws_eks_cluster" "demo" {
#   name     = "${var.cluster_name}"
#   role_arn = "${module.iam.iam_role_arn}"

#   vpc_config {
#     security_group_ids = ["${module.security_groups.demo-cluster_id}"]
#     subnet_ids         = ["${module.subnet_public.id}","${module.subnet_private_01.id}"]
#   }

#   # depends_on = [
#   #   "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy",
#   #   "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSServicePolicy",
#   # ]
# }
