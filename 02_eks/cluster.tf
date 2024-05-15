module "eks" {
  source  = "registry.terraform.io/terraform-aws-modules/eks/aws"
  version = "~> 20.0" # sync with eks_managed_node_group module version in node_group.tf

  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  tags            = var.tags

  # networking
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.vpc_subnet_ids
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # eks cluster settings
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  kms_key_aliases           = ["alias/eks_cluster_secrets_key"]

  cluster_addons = {
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni    = {
      most_recent          = true
      before_compute       = true
      # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }
}
