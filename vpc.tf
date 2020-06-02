module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  name            = "${var.name}"
  cidr            = "${var.vpc_cidr}"
  azs             = "${var.az}"
  
  private_subnets = [
                        for num in var.private_subnet_numbers:
                        cidrsubnet(var.vpc_cidr, 8, num)
                     ]
  public_subnets  = [
                        for num in var.public_subnet_numbers:
                        cidrsubnet(var.vpc_cidr, 8, num)
                     ]

  enable_nat_gateway = true
  enable_vpn_gateway = true

}