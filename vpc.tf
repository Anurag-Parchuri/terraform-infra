module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  name            = "${var.name}"
  cidr            = "${var.vpc_cidr}"
  azs             = data.aws_availability_zones.available.names

  private_subnets = [
                        for num in var.private_subnet_numbers:
                        cidrsubnet(var.vpc_cidr, 8, num)
                     ]
  
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.name}-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"   = "1"
  }
  
  public_subnets  = [
                        for num in var.public_subnet_numbers:
                        cidrsubnet(var.vpc_cidr, 8, num)
                     ]

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.name}-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                        = "1"
  }

  enable_nat_gateway = true
  enable_vpn_gateway = true

 

} 