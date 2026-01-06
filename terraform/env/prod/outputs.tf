# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

# EKS Outputs
output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_version" {
  description = "EKS cluster version"
  value       = module.eks.cluster_version
}

output "eks_oidc_issuer_url" {
  description = "OIDC issuer URL for IRSA"
  value       = module.eks.cluster_oidc_issuer_url
}

output "configure_kubectl" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}

# RDS Outputs
output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.db_instance_endpoint
}

output "rds_address" {
  description = "RDS address (hostname)"
  value       = module.rds.db_instance_address
}

output "database_name" {
  description = "Database name"
  value       = module.rds.db_name
}

# Secrets Manager Outputs
output "db_credentials_secret_name" {
  description = "Name of database credentials secret"
  value       = module.secrets.db_credentials_secret_name
}

output "app_config_secret_name" {
  description = "Name of application config secret"
  value       = module.secrets.app_config_secret_name
}

# IAM Outputs
output "payment_api_role_arn" {
  description = "ARN of payment-api service account role"
  value       = module.iam_irsa.payment_api_role_arn
}

output "payment_worker_role_arn" {
  description = "ARN of payment-worker service account role"
  value       = module.iam_irsa.payment_worker_role_arn
}

output "alb_controller_role_arn" {
  description = "ARN of ALB controller service account role"
  value       = module.iam_irsa.alb_controller_role_arn
}

# CloudWatch Outputs
output "cloudwatch_dashboard_name" {
  description = "CloudWatch dashboard name"
  value       = module.cloudwatch.dashboard_name
}

output "cloudwatch_log_groups" {
  description = "CloudWatch log groups"
  value = {
    eks_cluster    = module.cloudwatch.eks_cluster_log_group_name
    payment_api    = module.cloudwatch.payment_api_log_group_name
    payment_worker = module.cloudwatch.payment_worker_log_group_name
  }
}

# Security Group Outputs
output "eks_nodes_security_group_id" {
  description = "EKS nodes security group ID"
  value       = module.security_groups.eks_nodes_security_group_id
}

output "rds_security_group_id" {
  description = "RDS security group ID"
  value       = module.security_groups.rds_security_group_id
}
