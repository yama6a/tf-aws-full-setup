variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = "sandbox"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_subnet_ids" {
  description = "VPC Subnet IDs for cluster nodes"
  type        = set(string)
}

variable "instance_type" {
  description = "Instance type for the EKS nodes. Use at least m5.large for production clusters."
  type        = string
  default     = "t3.medium"
}

variable "max_node_count" {
  description = "Maximum number of nodes in the cluster"
  type        = number
  default     = 1
  validation {
    condition = var.max_node_count > 0
    error_message = "max_node_count must be greater than 0"
  }
}

variable "tags" {
  description = "Tags to be attached to all cluster resources"
  type        = map(string)
  default     = { env = "sandbox" }
}
