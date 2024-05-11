#output "cluster_id" {
#  description = "EKS cluster ID."
#  value       = module.eks.cluster_id
#}
#
#output "cluster_name" {
#  description = "EKS cluster Name."
#  value       = var.cluster_name
#}
#
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
#
#output "oidc_arn" {
#  description = "The ARN of the IAM OpenID Connect provider."
#  value       = module.eks.oidc_provider_arn
#}
#
#output "oidc_url" {
#  description = "The URL of the IAM OpenID Connect provider."
#  value       = module.eks.oidc_provider
#}
