# General Variables
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "finpay"
}

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  default     = "production"
}

# VPC Variables
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (EKS worker nodes)"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "database_subnet_cidrs" {
  description = "CIDR blocks for database subnets"
  type        = list(string)
  default     = ["10.0.20.0/24", "10.0.21.0/24"]
}

# EKS Variables
variable "eks_cluster_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
  default     = "1.30"
}

variable "application_node_instance_types" {
  description = "Instance types for application node group"
  type        = list(string)
  default     = ["t3.large"]
}

variable "application_node_capacity_type" {
  description = "Capacity type for application nodes (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "application_node_desired_size" {
  description = "Desired number of application nodes"
  type        = number
  default     = 2
}

variable "application_node_min_size" {
  description = "Minimum number of application nodes"
  type        = number
  default     = 2
}

variable "application_node_max_size" {
  description = "Maximum number of application nodes"
  type        = number
  default     = 6
}

# RDS Variables
variable "database_name" {
  description = "Name of the database"
  type        = string
  default     = "paymentdb"
}

variable "db_master_username" {
  description = "Master username for RDS"
  type        = string
  default     = "dbadmin"
}

variable "rds_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "16.1"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.medium"
}

variable "rds_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 100
}

variable "rds_storage_type" {
  description = "Storage type (gp3, gp2, io1)"
  type        = string
  default     = "gp3"
}

variable "rds_multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = true
}

variable "rds_backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "rds_deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "rds_skip_final_snapshot" {
  description = "Skip final snapshot when deleting (false for production)"
  type        = bool
  default     = false
}

# Secrets Manager Variables
variable "secrets_rotation_days" {
  description = "Number of days between secret rotations"
  type        = number
  default     = 90
}

variable "create_kms_key" {
  description = "Create KMS key for secrets encryption"
  type        = bool
  default     = false
}

# Application Configuration
variable "payment_namespace" {
  description = "Kubernetes namespace for payment applications"
  type        = string
  default     = "prod"
}

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

# CloudWatch Variables
variable "cloudwatch_log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 30
}

variable "cloudwatch_alarm_email" {
  description = "Email for CloudWatch alarm notifications"
  type        = string
  default     = ""
}
