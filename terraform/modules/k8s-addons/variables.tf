variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "Endpoint of the EKS cluster (used for dependency ordering)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the cluster is deployed"
  type        = string
}

variable "alb_controller_role_arn" {
  description = "IAM role ARN for AWS Load Balancer Controller"
  type        = string
}

variable "external_secrets_role_arn" {
  description = "IAM role ARN for External Secrets Operator"
  type        = string
}

variable "payment_namespace" {
  description = "Kubernetes namespace for payment application"
  type        = string
  default     = "prod"
}
