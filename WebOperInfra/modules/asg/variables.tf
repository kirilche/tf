variable "cluster_name" {}

variable "cluster_endpoint" {}
variable "cluster_ca" {}
variable "cluster_version" {}
variable "iam_instance_profile" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "security_groups" {
  type    = list(string)
  default = []
}

variable "vpc_zone_identifier" {
  type    = list(string)
  default = []
}
