variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
}

variable "tags" {
  description = "Tags to be attached to all AWS resources"
  type        = map(string)
  default     = { env = "sandbox" }
}

variable "oidc_url" {
  description = "The URL of the IAM OpenID Connect provider."
  type        = string
}

variable "oidc_arn" {
  description = "The ARN of the IAM OpenID Connect provider."
  type        = string
}
