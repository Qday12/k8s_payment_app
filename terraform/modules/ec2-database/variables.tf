variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the database instance"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for EBS volume"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "eks_nodes_security_group_id" {
  description = "Security group ID of EKS nodes"
  type        = string
}

variable "eks_cluster_security_group_id" {
  description = "Security group ID of EKS cluster-managed security group"
  type        = string
}

variable "rds_security_group_id" {
  description = "Security group ID of RDS instance"
  type        = string
}

variable "enable_rds_migration_access" {
  description = "Enable bidirectional access between RDS and VM for migration"
  type        = bool
  default     = true
}

variable "db_volume_size" {
  description = "Size of EBS volume for PostgreSQL data (GB)"
  type        = number
  default     = 50
}

variable "db_volume_type" {
  description = "EBS volume type (gp3, io1, io2)"
  type        = string
  default     = "gp3"
}

variable "db_volume_iops" {
  description = "IOPS for EBS volume (gp3: 3000-16000)"
  type        = number
  default     = 3000
}

variable "db_volume_throughput" {
  description = "Throughput for EBS volume in MB/s (gp3: 125-1000)"
  type        = number
  default     = 125
}

variable "db_credentials_secret_arn" {
  description = "ARN of Secrets Manager secret containing DB credentials"
  type        = string
}

variable "postgres_version" {
  description = "PostgreSQL version to install"
  type        = string
  default     = "16"
}

variable "preserve_data_volume" {
  description = "Preserve EBS data volume on instance termination"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
