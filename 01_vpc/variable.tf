variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "sandbox"
}

variable "tags" {
  description = "Tags to be attached to all resources"
  type        = map(string)
  default     = { "env" = "sandbox" }
}
