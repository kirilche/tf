module "vpc" {
  source = "../../../modules/vpc"

  vpc_region = var.vpc_region
  vpc_name       = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block
}

module "subnet_public" {
  source = "../../../modules/subnet_public"

  vpc_id       = module.vpc.id
  vpc_region   = module.vpc.region
  subnet_name  = var.subnet_public
  subnet_cidr  = var.subnet_public_cidr
  subnet_az    = var.subnet_public_az
}

module "subnet_private_01" {
  source = "../../../modules/subnet_private"

  vpc_id       = module.vpc.id
  vpc_region   = module.vpc.region
  subnet_cidr  = var.subnet_private_01_cidr
  subnet_name  = var.subnet_private_01
  subnet_az    = var.subnet_private_01_az
}

module "security_groups" {
  source = "../../../modules/security_group"

  vpc_id       = module.vpc.id
}