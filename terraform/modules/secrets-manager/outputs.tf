output "db_credentials_secret_arn" {
  description = "ARN of the database credentials secret"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "db_credentials_secret_name" {
  description = "Name of the database credentials secret"
  value       = aws_secretsmanager_secret.db_credentials.name
}

output "app_config_secret_arn" {
  description = "ARN of the application config secret"
  value       = aws_secretsmanager_secret.app_config.arn
}

output "app_config_secret_name" {
  description = "Name of the application config secret"
  value       = aws_secretsmanager_secret.app_config.name
}

output "kms_key_id" {
  description = "KMS key ID for secrets encryption (if created)"
  value       = var.create_kms_key ? aws_kms_key.secrets[0].id : null
}

output "kms_key_arn" {
  description = "KMS key ARN for secrets encryption (if created)"
  value       = var.create_kms_key ? aws_kms_key.secrets[0].arn : null
}
