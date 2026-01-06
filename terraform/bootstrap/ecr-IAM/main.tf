data "aws_caller_identity" "current" {}

# ECR Repositories
module "ecr" {
  source = "../../modules/ecr"

  project_name          = var.project_name
  repositories          = var.repositories
  image_tag_mutability  = "IMMUTABLE"
  scan_on_push          = true
  image_retention_count = 10

  tags = { Environment = "shared" }
}

# GitHub OIDC Provider (already exists in AWS account)
data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

# IAM Role for GitHub Actions ECR Push
resource "aws_iam_role" "github_actions" {
  name = "${var.project_name}-github-actions-ecr-push"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = data.aws_iam_openid_connect_provider.github.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = { "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com" }
        StringLike   = { "token.actions.githubusercontent.com:sub" = "repo:${var.github_org}/${var.github_repo}:*" }
      }
    }]
  })

  tags = { Name = "${var.project_name}-github-actions-ecr-push" }
}

# ECR Push Policy
resource "aws_iam_role_policy" "ecr_push" {
  name = "ecr-push"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ECRAuth"
        Effect   = "Allow"
        Action   = ["ecr:GetAuthorizationToken"]
        Resource = "*"
      },
      {
        Sid    = "ECRPush"
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:DescribeImages",
          "ecr:ListImages"
        ]
        Resource = [
          module.ecr.repositories["payment-api"].arn,
          module.ecr.repositories["payment-worker"].arn
        ]
      }
    ]
  })
}
