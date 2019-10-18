variable "cluster_name" {
  default = "terraform-eks-cluster"
  type    = "string"
}


variable "vpc_region" {
  description = "AWS region"
  default     = "eu-west-1"
}


variable "vpc_name" {
  description = "VPC for building demos"
  default     = "eks-vpc"
}

variable "vpc_cidr_block" {
  description = "Uber IP addressing for demo Network"
  default     = "10.0.0.0/16"
}

# Public Subnet Config
variable "subnet_public" {
  description = "Public subnet for VPC"
  default     = "internal_lb_subnet"
}

variable "subnet_public_cidr" {
  description = "CIDR for public subnet"
  default     = "10.0.1.0/24"
}

variable "subnet_public_az" {
  description = "Availability zone for public subnet"
  default     = "eu-west-1a"
}

# Private Subnet 1 Config
variable "subnet_private_01" {
  description = "Private subnet for demo Network"
  default     = "nodes_subnet"
}

variable "subnet_private_01_cidr" {
  description = "CIDR for internal subnet"
  default     = "10.0.128.0/24"
}

variable "subnet_private_01_az" {
  description = "Region for private subnet"
  default     = "eu-west-1b"
}