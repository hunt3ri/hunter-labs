# EC2 Instance Config
ubuntu_ami_instance         = 1
instance_type               = "t3a.micro"
instance_name               = "sandbox"
associate_public_ip_address = true

# SG Config
sg_name                     = "Sandbox SG"
sg_description              = "SG for Sandbox Instance"
ingress_cidr_blocks         = ["0.0.0.0/0"]
ingress_rules               = ["all-all"]

# Key Pair Config
key_name                    = "labs-key"
public_key                  = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAsYO2EwLo9GQxVoDKdxxQSNw/Y9bukRO6YNpc3MPmKPQorbpawHqYsq15j2/48dHJqP4VUgSwEEcpl/L5zeRRFGxbb3Unf5IdSvCA9aHZSAVfpHZaJVN7Nf0pC3eRKSfYvu166KpoienQg8aswXCgildLb5MDfl7ul6tfrjd/rbyty58Jp51fPKvqpKS0mUn5MT6ToECBtubCEJ9xqupQ5qQpKIHVleSUy+tSAxvYQTuMAmQfYEVQrJn9W9T5dsyWUi4X1MeEri4xqN8ZqaM8lhXmqp0f/Bsjpa15dMjTOkWDadu44dC3lPgB5yW5dcQMtrGMA2LpEvSFhy91iJ9xmw== rsa-key-20210324"
