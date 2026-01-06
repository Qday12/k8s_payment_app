# EKS Cluster Role
resource "aws_iam_role" "eks_cluster" {
  name = "${var.project_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eks-cluster-role"
    }
  )
}

# Attach required policies to EKS Cluster Role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster.name
}

##################################################################################

# EKS Node Role
resource "aws_iam_role" "eks_nodes" {
  name = "${var.project_name}-eks-node-role"

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
      Name = "${var.project_name}-eks-node-role"
    }
  )
}

# Attach required policies to EKS Node Role
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "eks_container_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}

# CloudWatch logs policy for nodes
resource "aws_iam_policy" "node_cloudwatch_logs" {
  name        = "${var.project_name}-node-cloudwatch-logs"
  description = "Allow EKS nodes to write logs to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = "arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/eks/${var.cluster_name}/*"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "node_cloudwatch_logs" {
  policy_arn = aws_iam_policy.node_cloudwatch_logs.arn
  role       = aws_iam_role.eks_nodes.name
}

###################################################################################

# OIDC Provider for IRSA (IAM Roles for Service Accounts)
data "tls_certificate" "eks" {
  count = var.enable_irsa ? 1 : 0
  url   = var.cluster_oidc_issuer_url
}

resource "aws_iam_openid_connect_provider" "eks" {
  count = var.enable_irsa ? 1 : 0

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks[0].certificates[0].sha1_fingerprint]
  url             = var.cluster_oidc_issuer_url

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eks-irsa"
    }
  )
}

# IRSA Role for payment-api (Secrets Manager read access)
resource "aws_iam_role" "payment_api" {
  count = var.enable_irsa ? 1 : 0
  name  = "${var.project_name}-payment-api-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks[0].arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(var.cluster_oidc_issuer_url, "https://", "")}:sub" = "system:serviceaccount:${var.payment_namespace}:payment-api"
            "${replace(var.cluster_oidc_issuer_url, "https://", "")}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-payment-api-role"
    }
  )
}

# Policy for payment-api to read secrets
resource "aws_iam_policy" "payment_api_secrets" {
  count       = var.enable_irsa ? 1 : 0
  name        = "${var.project_name}-payment-api-secrets"
  description = "Allow payment-api to read database credentials from Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = var.db_secret_arn
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "payment_api_secrets" {
  count      = var.enable_irsa ? 1 : 0
  policy_arn = aws_iam_policy.payment_api_secrets[0].arn
  role       = aws_iam_role.payment_api[0].name
}

# IRSA Role for payment-worker (CloudWatch metrics write)
resource "aws_iam_role" "payment_worker" {
  count = var.enable_irsa ? 1 : 0
  name  = "${var.project_name}-payment-worker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks[0].arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(var.cluster_oidc_issuer_url, "https://", "")}:sub" = "system:serviceaccount:${var.payment_namespace}:payment-worker"
            "${replace(var.cluster_oidc_issuer_url, "https://", "")}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-payment-worker-role"
    }
  )
}

# Policy for payment-worker to write CloudWatch metrics
resource "aws_iam_policy" "payment_worker_cloudwatch" {
  count       = var.enable_irsa ? 1 : 0
  name        = "${var.project_name}-payment-worker-cloudwatch"
  description = "Allow payment-worker to write custom metrics to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "cloudwatch:namespace" = "FinPay/PaymentWorker"
          }
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "payment_worker_cloudwatch" {
  count      = var.enable_irsa ? 1 : 0
  policy_arn = aws_iam_policy.payment_worker_cloudwatch[0].arn
  role       = aws_iam_role.payment_worker[0].name
}

# ALB Ingress Controller IAM Role (for AWS Load Balancer Controller)
resource "aws_iam_role" "alb_controller" {
  count = var.enable_irsa ? 1 : 0
  name  = "${var.project_name}-alb-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks[0].arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(var.cluster_oidc_issuer_url, "https://", "")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
            "${replace(var.cluster_oidc_issuer_url, "https://", "")}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-alb-controller-role"
    }
  )
}

# Policy for ALB Controller
resource "aws_iam_policy" "alb_controller" {
  count       = var.enable_irsa ? 1 : 0
  name        = "${var.project_name}-alb-controller-policy"
  description = "Policy for AWS Load Balancer Controller"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "elasticloadbalancing:*",
          "ec2:CreateSecurityGroup",
          "ec2:CreateTags",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress"
        ]
        Resource = "*"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "alb_controller" {
  count      = var.enable_irsa ? 1 : 0
  policy_arn = aws_iam_policy.alb_controller[0].arn
  role       = aws_iam_role.alb_controller[0].name
}
