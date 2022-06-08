terraform {
  required_version = ">=1.1.5"

  backend "s3" {
    bucket         = "perfect-operational-environment-network-tf"
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

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::${lookup(var.environment, terraform.workspace)}:role/Role_For-S3_Creation"
  }

  default_tags {
    tags = local.mandatory_tag
  }
}