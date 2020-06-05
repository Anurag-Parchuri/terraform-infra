data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "${var.name}-eks-cluster"
  cluster_version = "1.16"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

}

module "eks-node-group" {
  source = "umotif-public/eks-node-group/aws"
  version = "~> 1.0"
  enabled = true
  cluster_name = data.aws_eks_cluster.cluster.name

  subnet_ids = module.vpc.private_subnets

  desired_size = "${var.desired_size}"
  min_size = 1
  max_size = "${var.max_size}"

  instance_types = "${var.instance_type}"
  disk_size = 50
  ec2_ssh_key = "eks-test"

  kubernetes_labels = {
    lifecycle = "OnDemand"
  }

  tags = {
    Environment = "test"
    Name = "${data.aws_eks_cluster.cluster.name}-worker-nodes"
  }
}

