resource "aws_eks_cluster" "demo" {
  name     = "${var.name}"
  role_arn = "${var.role_arn}"

  vpc_config {
    security_group_ids = "${var.sgs}"
    subnet_ids         = "${var.subnets}"
  }

  #   depends_on = [
  #     "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy",
  #     "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSServicePolicy",
  #   ]
}
