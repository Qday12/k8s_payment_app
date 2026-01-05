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

variable "log_retention_days" {
  description = "Number of days to retain logs in CloudWatch"
  type        = number
  default     = 30
}

variable "alarm_email" {
  description = "Email address for alarm notifications"
  type        = string
  default     = ""
}

variable "create_rds_alarms" {
  description = "Create RDS CloudWatch alarms"
  type        = bool
  default     = true
}

variable "db_instance_id" {
  description = "RDS instance ID for alarms"
  type        = string
  default     = ""
}

variable "rds_cpu_threshold" {
  description = "RDS CPU utilization threshold percentage"
  type        = number
  default     = 90
}

variable "rds_freeable_memory_threshold" {
  description = "RDS freeable memory threshold in bytes (1GB = 1073741824)"
  type        = number
  default     = 1073741824
}

variable "rds_free_storage_threshold" {
  description = "RDS free storage threshold in bytes (10GB = 10737418240)"
  type        = number
  default     = 10737418240
}

variable "application_error_threshold" {
  description = "Application error count threshold per 5 minutes"
  type        = number
  default     = 10
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
