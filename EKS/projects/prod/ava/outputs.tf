output "vpc" {
  value = "${module.vpc.name}"
}

output "vpc_region" {
  value = "${module.vpc.region}"
}

output "subnet_public" {
  value = "${module.subnet_public.name}"
}

output "subnet_public_az" {
  value = "${module.subnet_public.az}"
}

output "subnet_public_id" {
  value = "${module.subnet_public.id}"
}

output "subnet_private_01" {
  value = "${module.subnet_private_01.name}"
}

output "subnet_private_01_id" {
  value = "${module.subnet_private_01.id}"
}

output "subnet_private_01_az" {
  value = "${var.subnet_private_01_az}"
}

output "security_group_demo-node_id" {
  value = "${module.security_groups.demo-node_id}"
}

output "security_group_demo-cluster_id" {
  value = "${module.security_groups.demo-cluster_id}"
}