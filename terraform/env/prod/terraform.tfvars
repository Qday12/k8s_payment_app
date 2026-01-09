# AWS Configuration
aws_region   = "eu-central-1"
project_name = "finpay"
environment  = "production"

# VPC Configuration
vpc_cidr              = "10.0.0.0/16"
availability_zones    = ["eu-central-1a", "eu-central-1b"]
public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs  = ["10.0.10.0/24", "10.0.11.0/24"]
database_subnet_cidrs = ["10.0.20.0/24", "10.0.21.0/24"]

# EKS Configuration
eks_cluster_version = "1.29"

# Application Node Group
application_node_instance_types = ["t3.large"]
application_node_capacity_type  = "ON_DEMAND"
application_node_desired_size   = 2
application_node_min_size       = 2
application_node_max_size       = 6

# RDS Configuration
database_name               = "paymentdb"
db_master_username          = "dbadmin"
rds_engine_version          = "16"
rds_instance_class          = "db.t3.medium"
rds_allocated_storage       = 20
rds_storage_type            = "gp3"
rds_multi_az                = true
rds_backup_retention_period = 7
rds_deletion_protection     = false
rds_skip_final_snapshot     = false

# Secrets Manager
secrets_rotation_days = 90
create_kms_key        = false

# Application Configuration
payment_namespace       = "prod"
payment_api_base_url    = "http://payment-api:8080"
payment_worker_base_url = "http://payment-worker:8090"
worker_cpu_load_ms      = 2000

# CloudWatch Configuration
cloudwatch_log_retention_days = 30
cloudwatch_alarm_email        = "blazejowski19@gmail.com"
