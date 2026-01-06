# Database Credentials Secret
resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "${var.project_name}/database/credentials"
  description = "Database credentials for ${var.project_name}"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-db-credentials"
    }
  )
}

# Store the database credentials
resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = var.db_endpoint
    port     = var.db_port
    dbname   = var.db_name
    engine   = "postgres"
  })
}

# KMS Key for encrypting secrets
resource "aws_kms_key" "secrets" {
  count = var.create_kms_key ? 1 : 0

  description             = "KMS key for ${var.project_name} secrets encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-secrets-kms"
    }
  )
}

resource "aws_kms_alias" "secrets" {
  count = var.create_kms_key ? 1 : 0

  name          = "alias/${var.project_name}-secrets"
  target_key_id = aws_kms_key.secrets[0].key_id
}

# Application Configuration Secret (for other app configs)
resource "aws_secretsmanager_secret" "app_config" {
  name                    = "${var.project_name}/app/config"
  description             = "Application configuration for ${var.project_name}"
  recovery_window_in_days = 0

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-app-config"
    }
  )
}

# Store application configuration
resource "aws_secretsmanager_secret_version" "app_config" {
  secret_id = aws_secretsmanager_secret.app_config.id

  secret_string = jsonencode({
    payment_api_base_url    = var.payment_api_base_url
    payment_worker_base_url = var.payment_worker_base_url
    worker_cpu_load_ms      = var.worker_cpu_load_ms
  })
}
