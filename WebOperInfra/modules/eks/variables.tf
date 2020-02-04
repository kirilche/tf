variable "name" {}
variable "role_arn" {}

variable "sgs" {
  type = list(string)
}

variable "subnets" {
  type = list(string)
}
