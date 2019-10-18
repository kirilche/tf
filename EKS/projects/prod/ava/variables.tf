variable "vpc_region" {
  description = "AWS region"
  default     = "eu-west-1"
}


variable "vpc_name" {
  description = "VPC for building demos"
  default     = "pacific"
}

variable "vpc_cidr_block" {
  description = "Uber IP addressing for demo Network"
  default     = "10.0.0.0/16"
}