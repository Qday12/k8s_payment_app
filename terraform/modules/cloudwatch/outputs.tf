output "eks_cluster_log_group_name" {
  description = "Name of EKS cluster log group"
  value       = aws_cloudwatch_log_group.eks_cluster.name
}

output "application_log_group_name" {
  description = "Name of application log group"
  value       = aws_cloudwatch_log_group.application.name
}

output "payment_api_log_group_name" {
  description = "Name of payment-api log group"
  value       = aws_cloudwatch_log_group.payment_api.name
}

output "payment_worker_log_group_name" {
  description = "Name of payment-worker log group"
  value       = aws_cloudwatch_log_group.payment_worker.name
}

output "sns_topic_arn" {
  description = "ARN of SNS topic for alarms"
  value       = aws_sns_topic.alarms.arn
}

output "dashboard_name" {
  description = "Name of CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}
