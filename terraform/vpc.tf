
data "aws_availability_zones" "zones" {
}

# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  # AC_AWS_0369
  #ts:skip=AC_AWS_0369 Cannot be ignored on external module
  source  = "terraform-aws-modules/vpc/aws"
  version = ">=3.14.0"

  name = "instruqt-sysdig-vpc"
  cidr = "10.0.0.0/16"

  private_subnets         = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets          = ["10.0.101.0/24", "10.0.102.0/24"]
  map_public_ip_on_launch = false

  azs = [
    data.aws_availability_zones.zones.names[0],
    data.aws_availability_zones.zones.names[1]
  ]

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false
  enable_vpn_gateway   = false
}