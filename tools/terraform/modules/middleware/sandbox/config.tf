# Backend must be initialised with terraform init
terraform {
  required_providers {
    aws = {
      version = ">= 3.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    key     = "middleware/sandbox/terraform.tfstate"
  }
}

provider "aws" {
  profile                 = var.profile
  region                  = var.region
}
