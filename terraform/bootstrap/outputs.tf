output "ecr_repositories" {
  value = module.ecr.repositories
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  value = var.aws_region
}
