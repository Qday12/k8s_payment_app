output "eks_cluster_role_arn" {
  description = "ARN of EKS cluster IAM role"
  value       = var.enable_irsa ? null : aws_iam_role.eks_cluster[0].arn
}

output "eks_cluster_role_name" {
  description = "Name of EKS cluster IAM role"
  value       = var.enable_irsa ? null : aws_iam_role.eks_cluster[0].name
}

output "eks_nodes_role_arn" {
  description = "ARN of EKS nodes IAM role"
  value       = var.enable_irsa ? null : aws_iam_role.eks_nodes[0].arn
}

output "eks_nodes_role_name" {
  description = "Name of EKS nodes IAM role"
  value       = var.enable_irsa ? null : aws_iam_role.eks_nodes[0].name
}

output "oidc_provider_arn" {
  description = "ARN of OIDC provider for IRSA"
  value       = var.enable_irsa ? aws_iam_openid_connect_provider.eks[0].arn : ""
}



output "payment_api_role_arn" {
  description = "ARN of payment-api service account IAM role"
  value       = var.enable_irsa ? aws_iam_role.payment_api[0].arn : ""
}

output "payment_worker_role_arn" {
  description = "ARN of payment-worker service account IAM role"
  value       = var.enable_irsa ? aws_iam_role.payment_worker[0].arn : ""
}

output "alb_controller_role_arn" {
  description = "ARN of ALB controller service account IAM role"
  value       = var.enable_irsa ? aws_iam_role.alb_controller[0].arn : ""
}

output "external_secrets_role_arn" {
  description = "ARN of External Secrets Operator service account IAM role"
  value       = var.enable_irsa ? aws_iam_role.external_secrets[0].arn : ""
}
