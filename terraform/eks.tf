module "eks" {
  source = "terraform-aws-modules/eks/aws"
  #they use latest one by default so no need for version

  cluster_name    = local.name
  cluster_version = "1.24"

  cluster_endpoint_public_access       = true          #don't do this in production
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"] #anyone can access but only recommened for testing

  enable_irsa = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  eks_managed_node_group_defaults = {
    disk_size      = 50
    instance_types = ["t3a.large", "t3.large"]
  }

  eks_managed_node_groups = {
    default = {}
  }

  tags = local.tags
}