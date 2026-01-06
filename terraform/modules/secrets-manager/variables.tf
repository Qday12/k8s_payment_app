variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "create_kms_key" {
  description = "Create a KMS key for secrets encryption"
  type        = bool
  default     = false
}

# Database credentials
variable "db_username" {
  description = "Database master username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "db_endpoint" {
  description = "Database endpoint (hostname:port or just hostname)"
  type        = string
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Database name"
  type        = string
}

# Application configuration
variable "payment_api_base_url" {
  description = "Base URL for payment API"
  type        = string
  default     = "http://payment-api:8080"
}

variable "payment_worker_base_url" {
  description = "Base URL for payment worker"
  type        = string
  default     = "http://payment-worker:8090"
}

variable "worker_cpu_load_ms" {
  description = "CPU load duration in milliseconds for worker"
  type        = number
  default     = 2000
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
