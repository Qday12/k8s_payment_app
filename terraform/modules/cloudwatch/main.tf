# CloudWatch Log Groups for EKS
resource "aws_cloudwatch_log_group" "eks_cluster" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.log_retention_days

  lifecycle {
    ignore_changes = [name]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eks-cluster-logs"
    }
  )
}

# CloudWatch Log Group for Application Logs (Fluent Bit)
resource "aws_cloudwatch_log_group" "application" {
  name              = "/aws/eks/${var.cluster_name}/application"
  retention_in_days = var.log_retention_days

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-application-logs"
    }
  )
}

# CloudWatch Log Group for payment-api
resource "aws_cloudwatch_log_group" "payment_api" {
  name              = "/aws/eks/${var.cluster_name}/payment-api"
  retention_in_days = var.log_retention_days

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-payment-api-logs"
    }
  )
}

# CloudWatch Log Group for payment-worker
resource "aws_cloudwatch_log_group" "payment_worker" {
  name              = "/aws/eks/${var.cluster_name}/payment-worker"
  retention_in_days = var.log_retention_days

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-payment-worker-logs"
    }
  )
}

# SNS Topic for CloudWatch Alarms
resource "aws_sns_topic" "alarms" {
  name = "${var.project_name}-cloudwatch-alarms"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-alarms"
    }
  )
}

# SNS Topic Subscription (Email)
resource "aws_sns_topic_subscription" "alarm_email" {
  count = var.alarm_email != "" ? 1 : 0

  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

# CloudWatch Alarm - RDS High CPU
resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  count = var.create_rds_alarms ? 1 : 0

  alarm_name          = "${var.project_name}-rds-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = var.rds_cpu_threshold
  alarm_description   = "This metric monitors RDS CPU utilization"
  alarm_actions       = [aws_sns_topic.alarms.arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = var.tags
}

# CloudWatch Alarm - RDS High Memory
resource "aws_cloudwatch_metric_alarm" "rds_memory" {
  count = var.create_rds_alarms ? 1 : 0

  alarm_name          = "${var.project_name}-rds-low-memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = var.rds_freeable_memory_threshold
  alarm_description   = "This metric monitors RDS freeable memory"
  alarm_actions       = [aws_sns_topic.alarms.arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = var.tags
}

# CloudWatch Alarm - RDS Storage Space
resource "aws_cloudwatch_metric_alarm" "rds_storage" {
  count = var.create_rds_alarms ? 1 : 0

  alarm_name          = "${var.project_name}-rds-low-storage"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = var.rds_free_storage_threshold
  alarm_description   = "This metric monitors RDS free storage space"
  alarm_actions       = [aws_sns_topic.alarms.arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = var.tags
}

# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "CPUUtilization", { stat = "Average", label = "RDS CPU" }],
          ]
          period = 300
          region = var.region
          title  = "RDS CPU Utilization"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "DatabaseConnections", { stat = "Average", label = "DB Connections" }],
          ]
          period = 300
          region = var.region
          title  = "RDS Database Connections"
        }
      },
      {
        type = "log"
        properties = {
          query  = "SOURCE '/aws/eks/${var.cluster_name}/application' | fields @timestamp, @message | sort @timestamp desc | limit 50"
          region = var.region
          title  = "Recent Application Logs"
        }
      }
    ]
  })
}

# CloudWatch Log Metric Filter - Application Errors
resource "aws_cloudwatch_log_metric_filter" "application_errors" {
  name           = "${var.project_name}-application-errors"
  log_group_name = aws_cloudwatch_log_group.application.name
  pattern        = "[time, request_id, level = ERROR*, ...]"

  metric_transformation {
    name      = "ApplicationErrorCount"
    namespace = "FinPay/Application"
    value     = "1"
  }
}

# CloudWatch Alarm - High Application Error Rate
resource "aws_cloudwatch_metric_alarm" "application_errors" {
  alarm_name          = "${var.project_name}-high-error-rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApplicationErrorCount"
  namespace           = "FinPay/Application"
  period              = "300"
  statistic           = "Sum"
  threshold           = var.application_error_threshold
  alarm_description   = "This metric monitors application error count"
  alarm_actions       = [aws_sns_topic.alarms.arn]
  treat_missing_data  = "notBreaching"

  tags = var.tags
}
