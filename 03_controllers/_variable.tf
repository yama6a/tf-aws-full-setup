variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
}

variable "tags" {
  description = "Tags to be attached to all AWS resources"
  type        = map(string)
  default     = { env = "sandbox" }
}
