# terraform {
#     required_providers {
#     port-labs = {
#       source  = "getport/port"
#       version = ">= 1.0"
#     }
#   }
# }
terraform {
  required_version = "> 1.1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "test-port-788489449561-tf-state"
    key    = "test/us-east-1/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "test-port-788489449561-tf-lock"
    encrypt = true
  }
}

provider "aws" {
     region = var.region
}

# provider "port" {

# }

data "aws_caller_identity" "current" {}

locals {
  env  = var.env
  project = "Test"
  vpc_cidr = var.vpc_cidr
  account_id = data.aws_caller_identity.current.account_id
  region = var.region
  common_tags = tomap({
    "Env"= var.env,
    "Project"= "Test",
    "ManagedBy"="Terraform"
  })
}
