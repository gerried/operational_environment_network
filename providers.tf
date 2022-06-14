
terraform {
  required_version = ">=1.1.5"

  backend "s3" {
      bucket = "operational-environment-network-tf"
      dynamodb_table = "terraform-lock"
      key = "path/env"
      region = "us-east-1"
      encrypt = "true"
  }
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.0"
      }
  }
}

provider "aws" {
  region  = var.region
  profile = "default"
  default_tags {
    tags = local.mandatory_tag
  }
}