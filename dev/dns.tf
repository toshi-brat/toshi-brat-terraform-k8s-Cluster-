# module "dns" {
#     source = "../tf_modules/Route_53"
#     domain_name = var.domain_name
#     vpc_id = module.vpc.vpc-id
# }