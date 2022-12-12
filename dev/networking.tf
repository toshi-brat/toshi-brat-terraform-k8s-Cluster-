module "vpc" {
  source          = "../tf_modules/networking"
  cidr            = var.cidr
  pub-snet        = var.pub-snet
  pri-snet        = var.pri-snet
  is_nat_required = var.nat_required
  nat-pub-id      = var.nat-pub-id
  environment     = local.environment
  buildby         = local.buildby
}

# module "vpc" {
#   source                  = "github.com/toshi-brat/terraform-aws-vpc.git"
#   ipv4_primary_cidr_block = var.cidr

# }

# module "subnet" {
#   source               = "github.com/toshi-brat/terraform-aws-dynamic-subnets.git"
#   vpc_id               = module.vpc.vpc_id
#   igw_id               = [module.vpc.igw_id]
#   ipv4_enabled         = true
#   nat_gateway_enabled  = false
#   nat_instance_enabled = false
#   ipv4_cidr_block      = [module.vpc.vpc_cidr_block]
#   #availability_zones   = var.availability_zones
# }