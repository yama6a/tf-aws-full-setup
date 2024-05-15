module "eks_managed_node_group" {
  source     = "registry.terraform.io/terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version    = "~> 20.0" # sync with eks module version in cluster.tf
  depends_on = [module.eks.cluster_addons] # eks module should finish addons first, to have VCNI prefix delegation.

  name           = "ng1"
  ami_type       = "AL2_x86_64"
  instance_types = [var.instance_type]
  labels         = { role = "worker" }
  tags           = var.tags

  cluster_name         = module.eks.cluster_name
  cluster_ip_family    = module.eks.cluster_ip_family
  cluster_service_cidr = module.eks.cluster_service_cidr

  use_custom_launch_template = false
  force_update_version       = true

  subnet_ids                        = var.vpc_subnet_ids
  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids            = [module.eks.node_security_group_id,]

  update_config = { max_unavailable = 1 }
  desired_size  = var.min_node_count
  min_size      = var.min_node_count
  max_size      = var.max_node_count
}
