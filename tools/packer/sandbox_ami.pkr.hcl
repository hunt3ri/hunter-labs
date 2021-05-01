variable "region" {
  description = "AWS region we're operating in, read from PKR_VAR_region env var"
}

variable "profile" {
  description = "AWS profile we're readings credentials from, read from PKR_VAR_profile env var"
}

variable "org_name" {
  description = "AWS profile we're readings credentials from, read from PKR_VAR_org_name env var"
}

source "amazon-ebs" "sandbox_ami" {
  # Access Config
  profile = "${var.profile}"
  region  = "${var.region}"

  # Run Config
  instance_type = "t3a.micro"
  source_ami_filter {
    filters = {
      # Latest Ubuntu LTS image
      name                = "ubuntu/images*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }

  # Communicator Config
  ssh_username = "ubuntu"

  # AMI Config
  ami_name = "${var.org_name}-sandbox-{{timestamp}}"
  ami_description = "Labs Sandbox AMI"
}

build {
  name    = "sandbox-image"
  sources = ["source.amazon-ebs.sandbox_ami"]

  # Use ansible to provision image
  provisioner "ansible" {
    playbook_file = "./provisioners/ansible/sandbox.yml"
    groups        = ["sandbox_ami"]
    user          = "${var.org_name}"    # Running as root will cause become:yes to fail so, run as different user
  }
}
