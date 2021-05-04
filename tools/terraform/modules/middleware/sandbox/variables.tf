#################
# EC2
#################

variable "instance_name" {
  description = "Name to be used on all resources as prefix"
}

variable "instance_type" {
  description = "The type of instance to start"
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
}

variable "ubuntu_ami_instance" {
  description = "Set to 1 to create a sandbox instance with vanilla Ubuntu LTS AKI"
}

variable "sandbox_ami_instance" {
  description = "Set to 1 to create instance with custom Labs sandbox AMI"
}

#################
# Key Pair
#################

variable "key_name" {
  description = "The name for the key pair."
}

variable "public_key" {
  description = "The public key material."
}

#################
# Security Group
#################

variable "sg_name" {
  description = "Name of security group"
}

variable "sg_description" {
  description = "Description of security group"
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
}

variable "ingress_rules" {
  description = "List of ingress rules to create by name"
}

#################
# Common
#################

variable "bucket" {
  description = "Environment infra is running in, read from TF_VAR_bucket env var"
}

variable "environment" {
  description = "Environment infra is running in, read from TF_VAR_environment env var"
}

variable "region" {
  description = "AWS region we're operating in, read from TF_VAR_region env var"
}

variable "profile" {
  description = "AWS profile we're readings credentials from, read from TF_VAR_profile env var"
}

variable "aws_account" {
  description = "AWS account we're running in read from TF_VAR_aws_account env var"
}

variable "org_name" {
  description = "Our Organisation name read from TF_VAR_org_name env var"
}