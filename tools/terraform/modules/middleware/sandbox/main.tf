resource "aws_key_pair" "keypair" {
  # Generate Key to allow ssh access
  key_name   = var.key_name
  public_key = var.public_key
}

module "sandbox_sg" {
  # SG registry module https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest
  source               = "terraform-aws-modules/security-group/aws"
  version              = "~> 3.0"

  name                 = var.sg_name
  description          = var.sg_description
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks  = var.ingress_cidr_blocks
  ingress_rules        = var.ingress_rules

  egress_rules         = ["all-all"]
}

resource "aws_instance" "ubuntu_cluster" {
  # Create EC2 Sandbox Instance(s) using base ubuntu AMI
  count                       = var.ubuntu_ami_instance

  ami                         = data.aws_ami.ubuntu_lts.id
  instance_type               = var.instance_type

  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_ids[count.index]
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = [module.sandbox_sg.this_security_group_id]

  key_name                    = aws_key_pair.keypair.key_name

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
    Owner = var.org_name
  }
}
