output "region" {
  description = "AWS region."
  value       = data.aws_region.current.name
}

output "cluster_name" {
  description = "EKS cluster Name."
  value       = var.cluster_name
}

output "oidc_arn" {
  description = "The ARN of the IAM OpenID Connect provider."
  value       = module.eks.oidc_provider_arn
}

output "oidc_url" {
  description = "The URL of the IAM OpenID Connect provider."
  value       = module.eks.oidc_provider
}

#output "cluster_arn" {
#  description = "EKS cluster ARN."
#  value       = module.eks.cluster_arn
#}
#
#output "cluster_security_group_id" {
#  description = "Security group ids attached to the cluster control plane."
#  value       = module.eks.cluster_primary_security_group_id
#}
#
#output "cluster_endpoint" {
#  description = "Endpoint for EKS control plane."
#  value       = module.eks.cluster_endpoint
#}
