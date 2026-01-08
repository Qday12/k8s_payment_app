output "alb_controller_chart_version" {
  description = "Version of AWS Load Balancer Controller Helm chart installed"
  value       = helm_release.aws_load_balancer_controller.version
}

output "external_secrets_chart_version" {
  description = "Version of External Secrets Operator Helm chart installed"
  value       = helm_release.external_secrets.version
}

output "cluster_secret_store_name" {
  description = "Name of the ClusterSecretStore"
  value       = "aws-secrets-manager"
}
