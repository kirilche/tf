variable "name" {}
variable "role_arn" {}

variable "sgs" {
  type = "list"
}

variable "subnets" {
  type = "list"
}
