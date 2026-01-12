# Data source for latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security Group for EC2 Database Instance
resource "aws_security_group" "db_vm" {
  name        = "${var.project_name}-db-vm-sg"
  description = "Security group for EC2 PostgreSQL instance"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-db-vm-sg"
    }
  )
}

# Ingress: PostgreSQL from EKS nodes
resource "aws_vpc_security_group_ingress_rule" "db_vm_from_eks" {
  security_group_id            = aws_security_group.db_vm.id
  description                  = "Allow PostgreSQL from EKS nodes"
  referenced_security_group_id = var.eks_nodes_security_group_id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

# Ingress: PostgreSQL from EKS cluster-managed security group
resource "aws_vpc_security_group_ingress_rule" "db_vm_from_eks_cluster" {
  security_group_id            = aws_security_group.db_vm.id
  description                  = "Allow PostgreSQL from EKS cluster-managed SG"
  referenced_security_group_id = var.eks_cluster_security_group_id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

# Ingress: PostgreSQL from RDS (for migration)
resource "aws_vpc_security_group_ingress_rule" "db_vm_from_rds" {
  count                        = var.enable_rds_migration_access ? 1 : 0
  security_group_id            = aws_security_group.db_vm.id
  description                  = "Allow PostgreSQL from RDS for migration"
  referenced_security_group_id = var.rds_security_group_id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

# Egress: All traffic (for updates, package installation)
resource "aws_vpc_security_group_egress_rule" "db_vm_egress" {
  security_group_id = aws_security_group.db_vm.id
  description       = "Allow all outbound traffic"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Add ingress rule to RDS security group to allow connections FROM the VM
resource "aws_vpc_security_group_ingress_rule" "rds_from_db_vm" {
  count                        = var.enable_rds_migration_access ? 1 : 0
  security_group_id            = var.rds_security_group_id
  description                  = "Allow PostgreSQL from DB VM for migration"
  referenced_security_group_id = aws_security_group.db_vm.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

# IAM Role for EC2 Instance
resource "aws_iam_role" "db_vm" {
  name = "${var.project_name}-db-vm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-db-vm-role"
    }
  )
}

# IAM Policy for Secrets Manager access
resource "aws_iam_role_policy" "db_vm_secrets" {
  name = "${var.project_name}-db-vm-secrets-policy"
  role = aws_iam_role.db_vm.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = [
          var.db_credentials_secret_arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach SSM policy for Session Manager access
resource "aws_iam_role_policy_attachment" "db_vm_ssm" {
  role       = aws_iam_role.db_vm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "db_vm" {
  name = "${var.project_name}-db-vm-instance-profile"
  role = aws_iam_role.db_vm.name

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-db-vm-instance-profile"
    }
  )
}

# EBS Volume for PostgreSQL data
resource "aws_ebs_volume" "db_data" {
  availability_zone = var.availability_zone
  size              = var.db_volume_size
  type              = var.db_volume_type
  iops              = var.db_volume_type == "gp3" ? var.db_volume_iops : null
  throughput        = var.db_volume_type == "gp3" ? var.db_volume_throughput : null
  encrypted         = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-db-data"
    }
  )
}

# EC2 Instance for PostgreSQL
resource "aws_instance" "db_vm" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.db_vm.id]
  iam_instance_profile   = aws_iam_instance_profile.db_vm.name

  # Use IMDSv2 only (security best practice)
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  # Root volume configuration
  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    encrypted   = true
  }

  # User data script for initial setup
  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    db_volume_device = "/dev/nvme1n1"
    postgres_version = var.postgres_version
  }))

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-db-vm"
    }
  )

  lifecycle {
    ignore_changes = [user_data]
  }
}

# Attach EBS volume to instance
resource "aws_volume_attachment" "db_data" {
  device_name = "/dev/nvme1n1"
  volume_id   = aws_ebs_volume.db_data.id
  instance_id = aws_instance.db_vm.id

  # Don't force detach on destroy
  skip_destroy = var.preserve_data_volume
}
