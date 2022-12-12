module "iam" {
  source = "../tf_modules/IAM"
  cluster_name = local.cluster_name
  
}