# Main Terraform Configuration for FinPay Payment Platform
# This file orchestrates all infrastructure modules

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

# Data source for current AWS account
data "aws_caller_identity" "current" {}

# Data source for availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  cluster_name = "${var.project_name}-${var.environment}-eks"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs

  tags = local.common_tags
}

# Security Groups Module
module "security_groups" {
  source = "../../modules/security-groups"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  cluster_name = local.cluster_name

  tags = local.common_tags

  depends_on = [module.vpc]
}

# IAM Module (Phase 1: without IRSA)
module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  cluster_name = local.cluster_name
  region       = var.aws_region
  account_id   = data.aws_caller_identity.current.account_id
  enable_irsa  = false # Will be enabled after EKS cluster is created

  tags = local.common_tags
}

# EKS Module
module "eks" {
  source = "../../modules/eks"

  cluster_name              = local.cluster_name
  cluster_version           = var.eks_cluster_version
  cluster_role_arn          = module.iam.eks_cluster_role_arn
  node_role_arn             = module.iam.eks_nodes_role_arn
  private_subnet_ids        = module.vpc.private_subnet_ids
  public_subnet_ids         = module.vpc.public_subnet_ids
  cluster_security_group_id = module.security_groups.eks_control_plane_security_group_id

  # Application node group settings
  application_node_instance_types = var.application_node_instance_types
  application_node_capacity_type  = var.application_node_capacity_type
  application_node_desired_size   = var.application_node_desired_size
  application_node_min_size       = var.application_node_min_size
  application_node_max_size       = var.application_node_max_size

  # System node group settings
  system_node_instance_types = var.system_node_instance_types
  system_node_desired_size   = var.system_node_desired_size
  system_node_min_size       = var.system_node_min_size
  system_node_max_size       = var.system_node_max_size

  tags = local.common_tags

  depends_on = [module.iam, module.security_groups]
}

# RDS Module
module "rds" {
  source = "../../modules/rds"

  project_name         = var.project_name
  database_name        = var.database_name
  master_username      = var.db_master_username
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  allocated_storage    = var.rds_allocated_storage
  storage_type         = var.rds_storage_type
  multi_az             = var.rds_multi_az
  db_subnet_group_name = module.vpc.db_subnet_group_name
  db_security_group_id = module.security_groups.rds_security_group_id

  backup_retention_period = var.rds_backup_retention_period
  deletion_protection     = var.rds_deletion_protection
  skip_final_snapshot     = var.rds_skip_final_snapshot

  tags = local.common_tags

  depends_on = [module.vpc, module.security_groups]
}

# Secrets Manager Module
module "secrets" {
  source = "../../modules/secrets-manager"

  project_name = var.project_name

  # Database credentials from RDS module
  db_username = module.rds.db_master_username
  db_password = module.rds.db_master_password
  db_endpoint = module.rds.db_instance_address
  db_port     = module.rds.db_instance_port
  db_name     = module.rds.db_name

  # Application configuration
  payment_api_base_url    = var.payment_api_base_url
  payment_worker_base_url = var.payment_worker_base_url
  worker_cpu_load_ms      = var.worker_cpu_load_ms

  rotation_days  = var.secrets_rotation_days
  create_kms_key = var.create_kms_key

  tags = local.common_tags

  depends_on = [module.rds]
}

# CloudWatch Module
module "cloudwatch" {
  source = "../../modules/cloudwatch"

  project_name       = var.project_name
  cluster_name       = local.cluster_name
  region             = var.aws_region
  log_retention_days = var.cloudwatch_log_retention_days
  alarm_email        = var.cloudwatch_alarm_email

  create_rds_alarms = true
  db_instance_id    = module.rds.db_instance_id

  tags = local.common_tags

  depends_on = [module.eks, module.rds]
}

# IAM Module (Phase 2: Enable IRSA after EKS is created)
# This creates IRSA roles for service accounts
module "iam_irsa" {
  source = "../../modules/iam"

  project_name            = var.project_name
  cluster_name            = local.cluster_name
  region                  = var.aws_region
  account_id              = data.aws_caller_identity.current.account_id
  enable_irsa             = true
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
  payment_namespace       = var.payment_namespace
  db_secret_arn           = module.secrets.db_credentials_secret_arn

  tags = local.common_tags

  depends_on = [module.eks, module.secrets]
}
