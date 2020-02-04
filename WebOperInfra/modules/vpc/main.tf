resource "aws_vpc" "primary_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = map(
      "Name", var.vpc_name,
      "kubernetes.io/cluster/${var.cluster_name}", "shared",
    )
}
