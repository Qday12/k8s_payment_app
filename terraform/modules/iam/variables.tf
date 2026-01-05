variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "enable_irsa" {
  description = "Enable IAM Roles for Service Accounts"
  type        = bool
  default     = false
}

variable "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL for the EKS cluster (required if enable_irsa is true)"
  type        = string
  default     = ""
}

variable "payment_namespace" {
  description = "Kubernetes namespace for payment applications"
  type        = string
  default     = "payment"
}

variable "db_secret_arn" {
  description = "ARN of the database secret in Secrets Manager"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
