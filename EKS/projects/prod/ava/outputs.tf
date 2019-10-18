output "vpc" {
  value = "${module.vpc.name}"
}

output "vpc_region" {
  value = "${module.vpc.region}"
}