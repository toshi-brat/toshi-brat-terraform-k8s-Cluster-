# terraform {
#   backend "s3" {
#     bucket = "my-tf-s3-backend"
#     key    = "prod/terraform.tfstate"
#     region = "ap-south-1"
#   }
# }

terraform {
  cloud {
    organization = "toshi-brat"

    workspaces {
      name = "dev_cli"
    }
  }

  # required_providers {
  # aws ={
  #   source = "hashicorp/aws"
  #   version = "~> 4.41"
  # }
  # }
}
