# ECR Module

resource "aws_ecr_repository" "this" {
  for_each             = var.repositories
  name                 = "${var.project_name}/${each.key}"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = merge(var.tags, { Name = "${var.project_name}-${each.key}" })
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each   = var.repositories
  repository = aws_ecr_repository.this[each.key].name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last ${var.image_retention_count} tagged images"
        selection    = { tagStatus = "tagged", tagPrefixList = ["v", "release"], countType = "imageCountMoreThan", countNumber = var.image_retention_count }
        action       = { type = "expire" }
      },
      {
        rulePriority = 2
        description  = "Remove untagged images older than 7 days"
        selection    = { tagStatus = "untagged", countType = "sinceImagePushed", countUnit = "days", countNumber = 7 }
        action       = { type = "expire" }
      }
    ]
  })
}
