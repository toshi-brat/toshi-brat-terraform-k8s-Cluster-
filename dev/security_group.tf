module "sg" {
  source     = "../tf_modules/security"
  sg_details = var.sg_details
  vpc_id     = module.vpc.vpc-id
}