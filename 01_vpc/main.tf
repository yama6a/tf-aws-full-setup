data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "registry.terraform.io/terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.vpc_name
  tags = var.tags
  azs  = data.aws_availability_zones.available.names

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  cidr                = "10.0.0.0/16"                                       # < 10.1.0.0    ( 65_534 IPs total )
  private_subnets     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]     # < 10.0.96.0   ( 24_570 IPs k8s   )
  public_subnets      = ["10.0.96.0/20", "10.0.112.0/20", "10.0.128.0/20"]  # < 10.0.144.0  ( 12_282 IPs pub   )
  elasticache_subnets = []
  database_subnets    = []
  redshift_subnets    = []

  create_database_subnet_group    = false
  create_elasticache_subnet_group = false
  create_redshift_subnet_group    = false
}
