variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "sandbox"
}

variable "tags" {
  description = "Tags to be attached to all AWS resources"
  type        = map(string)
  default     = { "env" = "sandbox" }
}
