vpc_name             = "hunter-labs-vpc"
cidr                 = "10.0.0.0/16"
azs                  = ["us-east-1a", "us-east-1b"]
public_subnets       = ["10.0.100.0/24", "10.0.200.0/24"]
enable_dns_hostnames = true
