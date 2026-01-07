variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name for tagging"
  type        = string
}

variable "eks_cluster_security_group_id" {
  description = "EKS cluster-managed security group ID (created by EKS, not Terraform). Required for RDS access from pods."
  type        = string
  default     = null
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
