data "terraform_remote_state" "vpc" {
  # Get global VPC vars
  backend = "s3"

  config = {
    bucket                  = var.bucket
    key                     = "common/vpc/terraform.tfstate"
    region                  = var.region
    profile                 = var.profile
  }
}


data "aws_ami" "ubuntu_lts" {
  # Get latest ubuntu base image
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images*ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # ubuntu images owned as by this owner, you can test filter as follows:
  # aws ec2 describe-images --filters "Name=name,Values=ubuntu/images*ubuntu-focal-20.04-amd64-server-*"
  owners = ["099720109477"]
}

data "aws_ami" "hunter_labs_sandbox" {
  # Identify the latest labs sandbox image
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.org_name}-sandbox-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # restrict search to ami's within our account
  owners = [var.aws_account]
}