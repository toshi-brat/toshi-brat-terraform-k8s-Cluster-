module "vm" {
  source        = "../tf_modules/vm"
  sg            = lookup(module.sg.output-sg-id, "web-server", null)
  ami           = var.ami
  instance_type = var.instance_type
  key-pair      = var.key-pair
  cluster_name  = "my-k8-cluster"
  pub-id        = lookup(module.vpc.pub-snet-id, "s1", null)
  worker_subnet_ids = [lookup(module.vpc.pub-snet-id, "s2", null),lookup(module.vpc.pub-snet-id, "s3", null)]
  master_iam_instance_profile = module.iam.master_profile
  node_iam_instance_profile = module.iam.node_profile
}

# module "vm" {
#   source = "../tf_modules/vm"
#   for_each = var.instance
#   sg = lookup(module.sg.output-sg-id, "web-server", null)
#   ami = var.ami
#   instance_type = var.instance_type
#   key-pair = var.key-pair
#   pub-id = lookup(module.vpc.pub-snet-id, "${each.value}", null)
# }
