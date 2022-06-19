
terraform {
  required_version = ">=1.1.5"

  backend "s3" {
    bucket         = "operational-environment-network-tf"
    dynamodb_table = "terraform-lock"
    key            = "path/env"
    region         = "us-east-1"
    encrypt        = "true"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${lookup(var.env, terraform.workspace)}:role/Terraform_Admin_Role"
  }
  default_tags {
    tags = local.mandatory_tag
  }
}

# arn:aws:iam::${lookup(var.env,terraform.workspace)}:role/Terraform_Admin_Role

# variable "env" {
#   description = "List of all accounts"
#   type = map(string)
#   default = {
#     "sbx" = "010342263745"
#     "dev" = "883250726777"
#     "prod" = "524913668773"
#   }
# }
