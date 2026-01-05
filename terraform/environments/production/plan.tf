][0m][1mdata.aws_caller_identity.current: Reading...][0m][0m
][0m][1mdata.aws_availability_zones.available: Reading...][0m][0m
][0m][1mdata.aws_caller_identity.current: Read complete after 0s [id=408502715963]][0m
][0m][1mdata.aws_availability_zones.available: Read complete after 0s [id=eu-central-1]][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  ][32m+][0m create][0m
 ][36m<=][0m read (data resources)][0m

Terraform will perform the following actions:

][1m  # module.cloudwatch.aws_cloudwatch_dashboard.main][0m will be created
][0m  ][32m+][0m][0m resource "aws_cloudwatch_dashboard" "main" {
      ][32m+][0m][0m dashboard_arn  = (known after apply)
      ][32m+][0m][0m dashboard_body = jsonencode(
            {
              ][32m+][0m][0m widgets = [
                  ][32m+][0m][0m {
                      ][32m+][0m][0m properties = {
                          ][32m+][0m][0m metrics = [
                              ][32m+][0m][0m [
                                  ][32m+][0m][0m "AWS/RDS",
                                  ][32m+][0m][0m "CPUUtilization",
                                  ][32m+][0m][0m {
                                      ][32m+][0m][0m label = "RDS CPU"
                                      ][32m+][0m][0m stat  = "Average"
                                    },
                                ],
                            ]
                          ][32m+][0m][0m period  = 300
                          ][32m+][0m][0m region  = "eu-central-1"
                          ][32m+][0m][0m title   = "RDS CPU Utilization"
                        }
                      ][32m+][0m][0m type       = "metric"
                    },
                  ][32m+][0m][0m {
                      ][32m+][0m][0m properties = {
                          ][32m+][0m][0m metrics = [
                              ][32m+][0m][0m [
                                  ][32m+][0m][0m "AWS/RDS",
                                  ][32m+][0m][0m "DatabaseConnections",
                                  ][32m+][0m][0m {
                                      ][32m+][0m][0m label = "DB Connections"
                                      ][32m+][0m][0m stat  = "Average"
                                    },
                                ],
                            ]
                          ][32m+][0m][0m period  = 300
                          ][32m+][0m][0m region  = "eu-central-1"
                          ][32m+][0m][0m title   = "RDS Database Connections"
                        }
                      ][32m+][0m][0m type       = "metric"
                    },
                  ][32m+][0m][0m {
                      ][32m+][0m][0m properties = {
                          ][32m+][0m][0m query  = "SOURCE '/aws/eks/finpay-production-eks/application' | fields @timestamp, @message | sort @timestamp desc | limit 50"
                          ][32m+][0m][0m region = "eu-central-1"
                          ][32m+][0m][0m title  = "Recent Application Logs"
                        }
                      ][32m+][0m][0m type       = "log"
                    },
                ]
            }
        )
      ][32m+][0m][0m dashboard_name = "finpay-dashboard"
      ][32m+][0m][0m id             = (known after apply)
    }

][1m  # module.cloudwatch.aws_cloudwatch_log_group.application][0m will be created
][0m  ][32m+][0m][0m resource "aws_cloudwatch_log_group" "application" {
      ][32m+][0m][0m arn               = (known after apply)
      ][32m+][0m][0m id                = (known after apply)
      ][32m+][0m][0m log_group_class   = (known after apply)
      ][32m+][0m][0m name              = "/aws/eks/finpay-production-eks/application"
      ][32m+][0m][0m name_prefix       = (known after apply)
      ][32m+][0m][0m retention_in_days = 30
      ][32m+][0m][0m skip_destroy      = false
      ][32m+][0m][0m tags              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-application-logs"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all          = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-application-logs"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.cloudwatch.aws_cloudwatch_log_group.eks_cluster][0m will be created
][0m  ][32m+][0m][0m resource "aws_cloudwatch_log_group" "eks_cluster" {
      ][32m+][0m][0m arn               = (known after apply)
      ][32m+][0m][0m id                = (known after apply)
      ][32m+][0m][0m log_group_class   = (known after apply)
      ][32m+][0m][0m name              = "/aws/eks/finpay-production-eks/cluster"
      ][32m+][0m][0m name_prefix       = (known after apply)
      ][32m+][0m][0m retention_in_days = 30
      ][32m+][0m][0m skip_destroy      = false
      ][32m+][0m][0m tags              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-cluster-logs"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all          = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-cluster-logs"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.cloudwatch.aws_cloudwatch_log_group.payment_api][0m will be created
][0m  ][32m+][0m][0m resource "aws_cloudwatch_log_group" "payment_api" {
      ][32m+][0m][0m arn               = (known after apply)
      ][32m+][0m][0m id                = (known after apply)
      ][32m+][0m][0m log_group_class   = (known after apply)
      ][32m+][0m][0m name              = "/aws/eks/finpay-production-eks/payment-api"
      ][32m+][0m][0m name_prefix       = (known after apply)
      ][32m+][0m][0m retention_in_days = 30
      ][32m+][0m][0m skip_destroy      = false
      ][32m+][0m][0m tags              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-payment-api-logs"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all          = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-payment-api-logs"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.cloudwatch.aws_cloudwatch_log_group.payment_worker][0m will be created
][0m  ][32m+][0m][0m resource "aws_cloudwatch_log_group" "payment_worker" {
      ][32m+][0m][0m arn               = (known after apply)
      ][32m+][0m][0m id                = (known after apply)
      ][32m+][0m][0m log_group_class   = (known after apply)
      ][32m+][0m][0m name              = "/aws/eks/finpay-production-eks/payment-worker"
      ][32m+][0m][0m name_prefix       = (known after apply)
      ][32m+][0m][0m retention_in_days = 30
      ][32m+][0m][0m skip_destroy      = false
      ][32m+][0m][0m tags              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-payment-worker-logs"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all          = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-payment-worker-logs"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.cloudwatch.aws_cloudwatch_log_metric_filter.application_errors][0m will be created
][0m  ][32m+][0m][0m resource "aws_cloudwatch_log_metric_filter" "application_errors" {
      ][32m+][0m][0m id             = (known after apply)
      ][32m+][0m][0m log_group_name = "/aws/eks/finpay-production-eks/application"
      ][32m+][0m][0m name           = "finpay-application-errors"
      ][32m+][0m][0m pattern        = "[time, request_id, level = ERROR*, ...]"

      ][32m+][0m][0m metric_transformation {
          ][32m+][0m][0m name      = "ApplicationErrorCount"
          ][32m+][0m][0m namespace = "FinPay/Application"
          ][32m+][0m][0m unit      = "None"
          ][32m+][0m][0m value     = "1"
        }
    }

][1m  # module.cloudwatch.aws_cloudwatch_metric_alarm.application_errors][0m will be created
][0m  ][32m+][0m][0m resource "aws_cloudwatch_metric_alarm" "application_errors" {
      ][32m+][0m][0m actions_enabled                       = true
      ][32m+][0m][0m alarm_actions                         = (known after apply)
      ][32m+][0m][0m alarm_description                     = "This metric monitors application error count"
      ][32m+][0m][0m alarm_name                            = "finpay-high-error-rate"
      ][32m+][0m][0m arn                                   = (known after apply)
      ][32m+][0m][0m comparison_operator                   = "GreaterThanThreshold"
      ][32m+][0m][0m evaluate_low_sample_count_percentiles = (known after apply)
      ][32m+][0m][0m evaluation_periods                    = 1
      ][32m+][0m][0m id                                    = (known after apply)
      ][32m+][0m][0m metric_name                           = "ApplicationErrorCount"
      ][32m+][0m][0m namespace                             = "FinPay/Application"
      ][32m+][0m][0m period                                = 300
      ][32m+][0m][0m statistic                             = "Sum"
      ][32m+][0m][0m tags                                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m threshold                             = 10
      ][32m+][0m][0m treat_missing_data                    = "notBreaching"
    }

][1m  # module.cloudwatch.aws_cloudwatch_metric_alarm.rds_cpu[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
      ][32m+][0m][0m actions_enabled                       = true
      ][32m+][0m][0m alarm_actions                         = (known after apply)
      ][32m+][0m][0m alarm_description                     = "This metric monitors RDS CPU utilization"
      ][32m+][0m][0m alarm_name                            = "finpay-rds-high-cpu"
      ][32m+][0m][0m arn                                   = (known after apply)
      ][32m+][0m][0m comparison_operator                   = "GreaterThanThreshold"
      ][32m+][0m][0m dimensions                            = (known after apply)
      ][32m+][0m][0m evaluate_low_sample_count_percentiles = (known after apply)
      ][32m+][0m][0m evaluation_periods                    = 2
      ][32m+][0m][0m id                                    = (known after apply)
      ][32m+][0m][0m metric_name                           = "CPUUtilization"
      ][32m+][0m][0m namespace                             = "AWS/RDS"
      ][32m+][0m][0m period                                = 300
      ][32m+][0m][0m statistic                             = "Average"
      ][32m+][0m][0m tags                                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m threshold                             = 90
      ][32m+][0m][0m treat_missing_data                    = "missing"
    }

][1m  # module.cloudwatch.aws_cloudwatch_metric_alarm.rds_memory[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_cloudwatch_metric_alarm" "rds_memory" {
      ][32m+][0m][0m actions_enabled                       = true
      ][32m+][0m][0m alarm_actions                         = (known after apply)
      ][32m+][0m][0m alarm_description                     = "This metric monitors RDS freeable memory"
      ][32m+][0m][0m alarm_name                            = "finpay-rds-low-memory"
      ][32m+][0m][0m arn                                   = (known after apply)
      ][32m+][0m][0m comparison_operator                   = "LessThanThreshold"
      ][32m+][0m][0m dimensions                            = (known after apply)
      ][32m+][0m][0m evaluate_low_sample_count_percentiles = (known after apply)
      ][32m+][0m][0m evaluation_periods                    = 2
      ][32m+][0m][0m id                                    = (known after apply)
      ][32m+][0m][0m metric_name                           = "FreeableMemory"
      ][32m+][0m][0m namespace                             = "AWS/RDS"
      ][32m+][0m][0m period                                = 300
      ][32m+][0m][0m statistic                             = "Average"
      ][32m+][0m][0m tags                                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m threshold                             = 1073741824
      ][32m+][0m][0m treat_missing_data                    = "missing"
    }

][1m  # module.cloudwatch.aws_cloudwatch_metric_alarm.rds_storage[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_cloudwatch_metric_alarm" "rds_storage" {
      ][32m+][0m][0m actions_enabled                       = true
      ][32m+][0m][0m alarm_actions                         = (known after apply)
      ][32m+][0m][0m alarm_description                     = "This metric monitors RDS free storage space"
      ][32m+][0m][0m alarm_name                            = "finpay-rds-low-storage"
      ][32m+][0m][0m arn                                   = (known after apply)
      ][32m+][0m][0m comparison_operator                   = "LessThanThreshold"
      ][32m+][0m][0m dimensions                            = (known after apply)
      ][32m+][0m][0m evaluate_low_sample_count_percentiles = (known after apply)
      ][32m+][0m][0m evaluation_periods                    = 1
      ][32m+][0m][0m id                                    = (known after apply)
      ][32m+][0m][0m metric_name                           = "FreeStorageSpace"
      ][32m+][0m][0m namespace                             = "AWS/RDS"
      ][32m+][0m][0m period                                = 300
      ][32m+][0m][0m statistic                             = "Average"
      ][32m+][0m][0m tags                                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m threshold                             = 10737418240
      ][32m+][0m][0m treat_missing_data                    = "missing"
    }

][1m  # module.cloudwatch.aws_sns_topic.alarms][0m will be created
][0m  ][32m+][0m][0m resource "aws_sns_topic" "alarms" {
      ][32m+][0m][0m arn                         = (known after apply)
      ][32m+][0m][0m beginning_archive_time      = (known after apply)
      ][32m+][0m][0m content_based_deduplication = false
      ][32m+][0m][0m fifo_throughput_scope       = (known after apply)
      ][32m+][0m][0m fifo_topic                  = false
      ][32m+][0m][0m id                          = (known after apply)
      ][32m+][0m][0m name                        = "finpay-cloudwatch-alarms"
      ][32m+][0m][0m name_prefix                 = (known after apply)
      ][32m+][0m][0m owner                       = (known after apply)
      ][32m+][0m][0m policy                      = (known after apply)
      ][32m+][0m][0m signature_version           = (known after apply)
      ][32m+][0m][0m tags                        = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-alarms"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                    = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-alarms"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tracing_config              = (known after apply)
    }

][1m  # module.cloudwatch.aws_sns_topic_subscription.alarm_email[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_sns_topic_subscription" "alarm_email" {
      ][32m+][0m][0m arn                             = (known after apply)
      ][32m+][0m][0m confirmation_timeout_in_minutes = 1
      ][32m+][0m][0m confirmation_was_authenticated  = (known after apply)
      ][32m+][0m][0m endpoint                        = "blazejowski19@gmail.com"
      ][32m+][0m][0m endpoint_auto_confirms          = false
      ][32m+][0m][0m filter_policy_scope             = (known after apply)
      ][32m+][0m][0m id                              = (known after apply)
      ][32m+][0m][0m owner_id                        = (known after apply)
      ][32m+][0m][0m pending_confirmation            = (known after apply)
      ][32m+][0m][0m protocol                        = "email"
      ][32m+][0m][0m raw_message_delivery            = false
      ][32m+][0m][0m topic_arn                       = (known after apply)
    }

][1m  # module.eks.aws_eks_addon.coredns][0m will be created
][0m  ][32m+][0m][0m resource "aws_eks_addon" "coredns" {
      ][32m+][0m][0m addon_name                  = "coredns"
      ][32m+][0m][0m addon_version               = "v1.10.1-eksbuild.6"
      ][32m+][0m][0m arn                         = (known after apply)
      ][32m+][0m][0m cluster_name                = "finpay-production-eks"
      ][32m+][0m][0m configuration_values        = (known after apply)
      ][32m+][0m][0m created_at                  = (known after apply)
      ][32m+][0m][0m id                          = (known after apply)
      ][32m+][0m][0m modified_at                 = (known after apply)
      ][32m+][0m][0m resolve_conflicts_on_create = "OVERWRITE"
      ][32m+][0m][0m resolve_conflicts_on_update = "PRESERVE"
      ][32m+][0m][0m tags                        = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                    = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.eks.aws_eks_addon.ebs_csi_driver][0m will be created
][0m  ][32m+][0m][0m resource "aws_eks_addon" "ebs_csi_driver" {
      ][32m+][0m][0m addon_name                  = "aws-ebs-csi-driver"
      ][32m+][0m][0m addon_version               = "v1.25.0-eksbuild.1"
      ][32m+][0m][0m arn                         = (known after apply)
      ][32m+][0m][0m cluster_name                = "finpay-production-eks"
      ][32m+][0m][0m configuration_values        = (known after apply)
      ][32m+][0m][0m created_at                  = (known after apply)
      ][32m+][0m][0m id                          = (known after apply)
      ][32m+][0m][0m modified_at                 = (known after apply)
      ][32m+][0m][0m resolve_conflicts_on_create = "OVERWRITE"
      ][32m+][0m][0m resolve_conflicts_on_update = "PRESERVE"
      ][32m+][0m][0m tags                        = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                    = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.eks.aws_eks_addon.kube_proxy][0m will be created
][0m  ][32m+][0m][0m resource "aws_eks_addon" "kube_proxy" {
      ][32m+][0m][0m addon_name                  = "kube-proxy"
      ][32m+][0m][0m addon_version               = "v1.28.2-eksbuild.2"
      ][32m+][0m][0m arn                         = (known after apply)
      ][32m+][0m][0m cluster_name                = "finpay-production-eks"
      ][32m+][0m][0m configuration_values        = (known after apply)
      ][32m+][0m][0m created_at                  = (known after apply)
      ][32m+][0m][0m id                          = (known after apply)
      ][32m+][0m][0m modified_at                 = (known after apply)
      ][32m+][0m][0m resolve_conflicts_on_create = "OVERWRITE"
      ][32m+][0m][0m resolve_conflicts_on_update = "PRESERVE"
      ][32m+][0m][0m tags                        = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                    = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.eks.aws_eks_addon.vpc_cni][0m will be created
][0m  ][32m+][0m][0m resource "aws_eks_addon" "vpc_cni" {
      ][32m+][0m][0m addon_name                  = "vpc-cni"
      ][32m+][0m][0m addon_version               = "v1.15.1-eksbuild.1"
      ][32m+][0m][0m arn                         = (known after apply)
      ][32m+][0m][0m cluster_name                = "finpay-production-eks"
      ][32m+][0m][0m configuration_values        = (known after apply)
      ][32m+][0m][0m created_at                  = (known after apply)
      ][32m+][0m][0m id                          = (known after apply)
      ][32m+][0m][0m modified_at                 = (known after apply)
      ][32m+][0m][0m resolve_conflicts_on_create = "OVERWRITE"
      ][32m+][0m][0m resolve_conflicts_on_update = "PRESERVE"
      ][32m+][0m][0m tags                        = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                    = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.eks.aws_eks_cluster.main][0m will be created
][0m  ][32m+][0m][0m resource "aws_eks_cluster" "main" {
      ][32m+][0m][0m arn                           = (known after apply)
      ][32m+][0m][0m bootstrap_self_managed_addons = true
      ][32m+][0m][0m certificate_authority         = (known after apply)
      ][32m+][0m][0m cluster_id                    = (known after apply)
      ][32m+][0m][0m created_at                    = (known after apply)
      ][32m+][0m][0m enabled_cluster_log_types     = [
          ][32m+][0m][0m "api",
          ][32m+][0m][0m "audit",
          ][32m+][0m][0m "authenticator",
          ][32m+][0m][0m "controllerManager",
          ][32m+][0m][0m "scheduler",
        ]
      ][32m+][0m][0m endpoint                      = (known after apply)
      ][32m+][0m][0m id                            = (known after apply)
      ][32m+][0m][0m identity                      = (known after apply)
      ][32m+][0m][0m name                          = "finpay-production-eks"
      ][32m+][0m][0m platform_version              = (known after apply)
      ][32m+][0m][0m role_arn                      = (known after apply)
      ][32m+][0m][0m status                        = (known after apply)
      ][32m+][0m][0m tags                          = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-production-eks"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                      = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-production-eks"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m version                       = "1.28"

      ][32m+][0m][0m access_config (known after apply)

      ][32m+][0m][0m kubernetes_network_config (known after apply)

      ][32m+][0m][0m upgrade_policy (known after apply)

      ][32m+][0m][0m vpc_config {
          ][32m+][0m][0m cluster_security_group_id = (known after apply)
          ][32m+][0m][0m endpoint_private_access   = true
          ][32m+][0m][0m endpoint_public_access    = true
          ][32m+][0m][0m public_access_cidrs       = (known after apply)
          ][32m+][0m][0m security_group_ids        = (known after apply)
          ][32m+][0m][0m subnet_ids                = (known after apply)
          ][32m+][0m][0m vpc_id                    = (known after apply)
        }
    }

][1m  # module.eks.aws_eks_node_group.application][0m will be created
][0m  ][32m+][0m][0m resource "aws_eks_node_group" "application" {
      ][32m+][0m][0m ami_type               = (known after apply)
      ][32m+][0m][0m arn                    = (known after apply)
      ][32m+][0m][0m capacity_type          = "ON_DEMAND"
      ][32m+][0m][0m cluster_name           = "finpay-production-eks"
      ][32m+][0m][0m disk_size              = (known after apply)
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m instance_types         = [
          ][32m+][0m][0m "t3.large",
        ]
      ][32m+][0m][0m labels                 = {
          ][32m+][0m][0m "role" = "application"
        }
      ][32m+][0m][0m node_group_name        = "finpay-production-eks-application-ng"
      ][32m+][0m][0m node_group_name_prefix = (known after apply)
      ][32m+][0m][0m node_role_arn          = (known after apply)
      ][32m+][0m][0m release_version        = (known after apply)
      ][32m+][0m][0m resources              = (known after apply)
      ][32m+][0m][0m status                 = (known after apply)
      ][32m+][0m][0m subnet_ids             = (known after apply)
      ][32m+][0m][0m tags                   = {
          ][32m+][0m][0m "Environment"                                     = "production"
          ][32m+][0m][0m "ManagedBy"                                       = "Terraform"
          ][32m+][0m][0m "Name"                                            = "finpay-production-eks-application-ng"
          ][32m+][0m][0m "Project"                                         = "finpay"
          ][32m+][0m][0m "k8s.io/cluster-autoscaler/enabled"               = "true"
          ][32m+][0m][0m "k8s.io/cluster-autoscaler/finpay-production-eks" = "owned"
        }
      ][32m+][0m][0m tags_all               = {
          ][32m+][0m][0m "Environment"                                     = "production"
          ][32m+][0m][0m "ManagedBy"                                       = "Terraform"
          ][32m+][0m][0m "Name"                                            = "finpay-production-eks-application-ng"
          ][32m+][0m][0m "Project"                                         = "finpay"
          ][32m+][0m][0m "k8s.io/cluster-autoscaler/enabled"               = "true"
          ][32m+][0m][0m "k8s.io/cluster-autoscaler/finpay-production-eks" = "owned"
        }
      ][32m+][0m][0m version                = (known after apply)

      ][32m+][0m][0m node_repair_config (known after apply)

      ][32m+][0m][0m scaling_config {
          ][32m+][0m][0m desired_size = 2
          ][32m+][0m][0m max_size     = 6
          ][32m+][0m][0m min_size     = 2
        }

      ][32m+][0m][0m update_config {
          ][32m+][0m][0m max_unavailable = 1
        }
    }

][1m  # module.eks.aws_eks_node_group.system][0m will be created
][0m  ][32m+][0m][0m resource "aws_eks_node_group" "system" {
      ][32m+][0m][0m ami_type               = (known after apply)
      ][32m+][0m][0m arn                    = (known after apply)
      ][32m+][0m][0m capacity_type          = "ON_DEMAND"
      ][32m+][0m][0m cluster_name           = "finpay-production-eks"
      ][32m+][0m][0m disk_size              = (known after apply)
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m instance_types         = [
          ][32m+][0m][0m "t3.medium",
        ]
      ][32m+][0m][0m labels                 = {
          ][32m+][0m][0m "role" = "system"
        }
      ][32m+][0m][0m node_group_name        = "finpay-production-eks-system-ng"
      ][32m+][0m][0m node_group_name_prefix = (known after apply)
      ][32m+][0m][0m node_role_arn          = (known after apply)
      ][32m+][0m][0m release_version        = (known after apply)
      ][32m+][0m][0m resources              = (known after apply)
      ][32m+][0m][0m status                 = (known after apply)
      ][32m+][0m][0m subnet_ids             = (known after apply)
      ][32m+][0m][0m tags                   = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-production-eks-system-ng"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all               = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-production-eks-system-ng"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m version                = (known after apply)

      ][32m+][0m][0m node_repair_config (known after apply)

      ][32m+][0m][0m scaling_config {
          ][32m+][0m][0m desired_size = 2
          ][32m+][0m][0m max_size     = 2
          ][32m+][0m][0m min_size     = 2
        }

      ][32m+][0m][0m taint {
          ][32m+][0m][0m effect = "NO_SCHEDULE"
          ][32m+][0m][0m key    = "CriticalAddonsOnly"
          ][32m+][0m][0m value  = "true"
        }

      ][32m+][0m][0m update_config {
          ][32m+][0m][0m max_unavailable = 1
        }
    }

][1m  # module.iam.aws_iam_policy.node_cloudwatch_logs][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_policy" "node_cloudwatch_logs" {
      ][32m+][0m][0m arn              = (known after apply)
      ][32m+][0m][0m attachment_count = (known after apply)
      ][32m+][0m][0m description      = "Allow EKS nodes to write logs to CloudWatch"
      ][32m+][0m][0m id               = (known after apply)
      ][32m+][0m][0m name             = "finpay-node-cloudwatch-logs"
      ][32m+][0m][0m name_prefix      = (known after apply)
      ][32m+][0m][0m path             = "/"
      ][32m+][0m][0m policy           = jsonencode(
            {
              ][32m+][0m][0m Statement = [
                  ][32m+][0m][0m {
                      ][32m+][0m][0m Action   = [
                          ][32m+][0m][0m "logs:CreateLogGroup",
                          ][32m+][0m][0m "logs:CreateLogStream",
                          ][32m+][0m][0m "logs:PutLogEvents",
                          ][32m+][0m][0m "logs:DescribeLogStreams",
                        ]
                      ][32m+][0m][0m Effect   = "Allow"
                      ][32m+][0m][0m Resource = "arn:aws:logs:eu-central-1:408502715963:log-group:/aws/eks/finpay-production-eks/*"
                    },
                ]
              ][32m+][0m][0m Version   = "2012-10-17"
            }
        )
      ][32m+][0m][0m policy_id        = (known after apply)
      ][32m+][0m][0m tags             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all         = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.iam.aws_iam_role.eks_cluster][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role" "eks_cluster" {
      ][32m+][0m][0m arn                   = (known after apply)
      ][32m+][0m][0m assume_role_policy    = jsonencode(
            {
              ][32m+][0m][0m Statement = [
                  ][32m+][0m][0m {
                      ][32m+][0m][0m Action    = "sts:AssumeRole"
                      ][32m+][0m][0m Effect    = "Allow"
                      ][32m+][0m][0m Principal = {
                          ][32m+][0m][0m Service = "eks.amazonaws.com"
                        }
                    },
                ]
              ][32m+][0m][0m Version   = "2012-10-17"
            }
        )
      ][32m+][0m][0m create_date           = (known after apply)
      ][32m+][0m][0m force_detach_policies = false
      ][32m+][0m][0m id                    = (known after apply)
      ][32m+][0m][0m managed_policy_arns   = (known after apply)
      ][32m+][0m][0m max_session_duration  = 3600
      ][32m+][0m][0m name                  = "finpay-eks-cluster-role"
      ][32m+][0m][0m name_prefix           = (known after apply)
      ][32m+][0m][0m path                  = "/"
      ][32m+][0m][0m tags                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-cluster-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-cluster-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m unique_id             = (known after apply)

      ][32m+][0m][0m inline_policy (known after apply)
    }

][1m  # module.iam.aws_iam_role.eks_nodes][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role" "eks_nodes" {
      ][32m+][0m][0m arn                   = (known after apply)
      ][32m+][0m][0m assume_role_policy    = jsonencode(
            {
              ][32m+][0m][0m Statement = [
                  ][32m+][0m][0m {
                      ][32m+][0m][0m Action    = "sts:AssumeRole"
                      ][32m+][0m][0m Effect    = "Allow"
                      ][32m+][0m][0m Principal = {
                          ][32m+][0m][0m Service = "ec2.amazonaws.com"
                        }
                    },
                ]
              ][32m+][0m][0m Version   = "2012-10-17"
            }
        )
      ][32m+][0m][0m create_date           = (known after apply)
      ][32m+][0m][0m force_detach_policies = false
      ][32m+][0m][0m id                    = (known after apply)
      ][32m+][0m][0m managed_policy_arns   = (known after apply)
      ][32m+][0m][0m max_session_duration  = 3600
      ][32m+][0m][0m name                  = "finpay-eks-node-role"
      ][32m+][0m][0m name_prefix           = (known after apply)
      ][32m+][0m][0m path                  = "/"
      ][32m+][0m][0m tags                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-node-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-node-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m unique_id             = (known after apply)

      ][32m+][0m][0m inline_policy (known after apply)
    }

][1m  # module.iam.aws_iam_role_policy_attachment.eks_cluster_policy][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
      ][32m+][0m][0m role       = "finpay-eks-cluster-role"
    }

][1m  # module.iam.aws_iam_role_policy_attachment.eks_cni_policy][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      ][32m+][0m][0m role       = "finpay-eks-node-role"
    }

][1m  # module.iam.aws_iam_role_policy_attachment.eks_container_registry_policy][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "eks_container_registry_policy" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ][32m+][0m][0m role       = "finpay-eks-node-role"
    }

][1m  # module.iam.aws_iam_role_policy_attachment.eks_vpc_resource_controller][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
      ][32m+][0m][0m role       = "finpay-eks-cluster-role"
    }

][1m  # module.iam.aws_iam_role_policy_attachment.eks_worker_node_policy][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
      ][32m+][0m][0m role       = "finpay-eks-node-role"
    }

][1m  # module.iam.aws_iam_role_policy_attachment.node_cloudwatch_logs][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "node_cloudwatch_logs" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = (known after apply)
      ][32m+][0m][0m role       = "finpay-eks-node-role"
    }

][1m  # module.iam_irsa.data.tls_certificate.eks[0]][0m will be read during apply
  # (config refers to values not yet known)
][0m ][36m<=][0m][0m data "tls_certificate" "eks" {
      ][32m+][0m][0m certificates = (known after apply)
      ][32m+][0m][0m id           = (known after apply)
      ][32m+][0m][0m url          = (known after apply)
    }

][1m  # module.iam_irsa.aws_iam_openid_connect_provider.eks[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_openid_connect_provider" "eks" {
      ][32m+][0m][0m arn             = (known after apply)
      ][32m+][0m][0m client_id_list  = [
          ][32m+][0m][0m "sts.amazonaws.com",
        ]
      ][32m+][0m][0m id              = (known after apply)
      ][32m+][0m][0m tags            = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-irsa"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all        = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-irsa"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m thumbprint_list = (known after apply)
      ][32m+][0m][0m url             = (known after apply)
    }

][1m  # module.iam_irsa.aws_iam_policy.alb_controller[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_policy" "alb_controller" {
      ][32m+][0m][0m arn              = (known after apply)
      ][32m+][0m][0m attachment_count = (known after apply)
      ][32m+][0m][0m description      = "Policy for AWS Load Balancer Controller"
      ][32m+][0m][0m id               = (known after apply)
      ][32m+][0m][0m name             = "finpay-alb-controller-policy"
      ][32m+][0m][0m name_prefix      = (known after apply)
      ][32m+][0m][0m path             = "/"
      ][32m+][0m][0m policy           = jsonencode(
            {
              ][32m+][0m][0m Statement = [
                  ][32m+][0m][0m {
                      ][32m+][0m][0m Action   = [
                          ][32m+][0m][0m "ec2:DescribeVpcs",
                          ][32m+][0m][0m "ec2:DescribeSubnets",
                          ][32m+][0m][0m "ec2:DescribeSecurityGroups",
                          ][32m+][0m][0m "elasticloadbalancing:*",
                          ][32m+][0m][0m "ec2:CreateSecurityGroup",
                          ][32m+][0m][0m "ec2:CreateTags",
                          ][32m+][0m][0m "ec2:AuthorizeSecurityGroupIngress",
                          ][32m+][0m][0m "ec2:RevokeSecurityGroupIngress",
                        ]
                      ][32m+][0m][0m Effect   = "Allow"
                      ][32m+][0m][0m Resource = "*"
                    },
                ]
              ][32m+][0m][0m Version   = "2012-10-17"
            }
        )
      ][32m+][0m][0m policy_id        = (known after apply)
      ][32m+][0m][0m tags             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all         = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.iam_irsa.aws_iam_policy.node_cloudwatch_logs][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_policy" "node_cloudwatch_logs" {
      ][32m+][0m][0m arn              = (known after apply)
      ][32m+][0m][0m attachment_count = (known after apply)
      ][32m+][0m][0m description      = "Allow EKS nodes to write logs to CloudWatch"
      ][32m+][0m][0m id               = (known after apply)
      ][32m+][0m][0m name             = "finpay-node-cloudwatch-logs"
      ][32m+][0m][0m name_prefix      = (known after apply)
      ][32m+][0m][0m path             = "/"
      ][32m+][0m][0m policy           = jsonencode(
            {
              ][32m+][0m][0m Statement = [
                  ][32m+][0m][0m {
                      ][32m+][0m][0m Action   = [
                          ][32m+][0m][0m "logs:CreateLogGroup",
                          ][32m+][0m][0m "logs:CreateLogStream",
                          ][32m+][0m][0m "logs:PutLogEvents",
                          ][32m+][0m][0m "logs:DescribeLogStreams",
                        ]
                      ][32m+][0m][0m Effect   = "Allow"
                      ][32m+][0m][0m Resource = "arn:aws:logs:eu-central-1:408502715963:log-group:/aws/eks/finpay-production-eks/*"
                    },
                ]
              ][32m+][0m][0m Version   = "2012-10-17"
            }
        )
      ][32m+][0m][0m policy_id        = (known after apply)
      ][32m+][0m][0m tags             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all         = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.iam_irsa.aws_iam_policy.payment_api_secrets[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_policy" "payment_api_secrets" {
      ][32m+][0m][0m arn              = (known after apply)
      ][32m+][0m][0m attachment_count = (known after apply)
      ][32m+][0m][0m description      = "Allow payment-api to read database credentials from Secrets Manager"
      ][32m+][0m][0m id               = (known after apply)
      ][32m+][0m][0m name             = "finpay-payment-api-secrets"
      ][32m+][0m][0m name_prefix      = (known after apply)
      ][32m+][0m][0m path             = "/"
      ][32m+][0m][0m policy           = (known after apply)
      ][32m+][0m][0m policy_id        = (known after apply)
      ][32m+][0m][0m tags             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all         = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.iam_irsa.aws_iam_policy.payment_worker_cloudwatch[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_policy" "payment_worker_cloudwatch" {
      ][32m+][0m][0m arn              = (known after apply)
      ][32m+][0m][0m attachment_count = (known after apply)
      ][32m+][0m][0m description      = "Allow payment-worker to write custom metrics to CloudWatch"
      ][32m+][0m][0m id               = (known after apply)
      ][32m+][0m][0m name             = "finpay-payment-worker-cloudwatch"
      ][32m+][0m][0m name_prefix      = (known after apply)
      ][32m+][0m][0m path             = "/"
      ][32m+][0m][0m policy           = jsonencode(
            {
              ][32m+][0m][0m Statement = [
                  ][32m+][0m][0m {
                      ][32m+][0m][0m Action    = [
                          ][32m+][0m][0m "cloudwatch:PutMetricData",
                        ]
                      ][32m+][0m][0m Condition = {
                          ][32m+][0m][0m StringEquals = {
                              ][32m+][0m][0m "cloudwatch:namespace" = "FinPay/PaymentWorker"
                            }
                        }
                      ][32m+][0m][0m Effect    = "Allow"
                      ][32m+][0m][0m Resource  = "*"
                    },
                ]
              ][32m+][0m][0m Version   = "2012-10-17"
            }
        )
      ][32m+][0m][0m policy_id        = (known after apply)
      ][32m+][0m][0m tags             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all         = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.iam_irsa.aws_iam_role.alb_controller[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role" "alb_controller" {
      ][32m+][0m][0m arn                   = (known after apply)
      ][32m+][0m][0m assume_role_policy    = (known after apply)
      ][32m+][0m][0m create_date           = (known after apply)
      ][32m+][0m][0m force_detach_policies = false
      ][32m+][0m][0m id                    = (known after apply)
      ][32m+][0m][0m managed_policy_arns   = (known after apply)
      ][32m+][0m][0m max_session_duration  = 3600
      ][32m+][0m][0m name                  = "finpay-alb-controller-role"
      ][32m+][0m][0m name_prefix           = (known after apply)
      ][32m+][0m][0m path                  = "/"
      ][32m+][0m][0m tags                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-alb-controller-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-alb-controller-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m unique_id             = (known after apply)

      ][32m+][0m][0m inline_policy (known after apply)
    }

][1m  # module.iam_irsa.aws_iam_role.eks_cluster][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role" "eks_cluster" {
      ][32m+][0m][0m arn                   = (known after apply)
      ][32m+][0m][0m assume_role_policy    = jsonencode(
            {
              ][32m+][0m][0m Statement = [
                  ][32m+][0m][0m {
                      ][32m+][0m][0m Action    = "sts:AssumeRole"
                      ][32m+][0m][0m Effect    = "Allow"
                      ][32m+][0m][0m Principal = {
                          ][32m+][0m][0m Service = "eks.amazonaws.com"
                        }
                    },
                ]
              ][32m+][0m][0m Version   = "2012-10-17"
            }
        )
      ][32m+][0m][0m create_date           = (known after apply)
      ][32m+][0m][0m force_detach_policies = false
      ][32m+][0m][0m id                    = (known after apply)
      ][32m+][0m][0m managed_policy_arns   = (known after apply)
      ][32m+][0m][0m max_session_duration  = 3600
      ][32m+][0m][0m name                  = "finpay-eks-cluster-role"
      ][32m+][0m][0m name_prefix           = (known after apply)
      ][32m+][0m][0m path                  = "/"
      ][32m+][0m][0m tags                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-cluster-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-cluster-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m unique_id             = (known after apply)

      ][32m+][0m][0m inline_policy (known after apply)
    }

][1m  # module.iam_irsa.aws_iam_role.eks_nodes][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role" "eks_nodes" {
      ][32m+][0m][0m arn                   = (known after apply)
      ][32m+][0m][0m assume_role_policy    = jsonencode(
            {
              ][32m+][0m][0m Statement = [
                  ][32m+][0m][0m {
                      ][32m+][0m][0m Action    = "sts:AssumeRole"
                      ][32m+][0m][0m Effect    = "Allow"
                      ][32m+][0m][0m Principal = {
                          ][32m+][0m][0m Service = "ec2.amazonaws.com"
                        }
                    },
                ]
              ][32m+][0m][0m Version   = "2012-10-17"
            }
        )
      ][32m+][0m][0m create_date           = (known after apply)
      ][32m+][0m][0m force_detach_policies = false
      ][32m+][0m][0m id                    = (known after apply)
      ][32m+][0m][0m managed_policy_arns   = (known after apply)
      ][32m+][0m][0m max_session_duration  = 3600
      ][32m+][0m][0m name                  = "finpay-eks-node-role"
      ][32m+][0m][0m name_prefix           = (known after apply)
      ][32m+][0m][0m path                  = "/"
      ][32m+][0m][0m tags                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-node-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-node-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m unique_id             = (known after apply)

      ][32m+][0m][0m inline_policy (known after apply)
    }

][1m  # module.iam_irsa.aws_iam_role.payment_api[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role" "payment_api" {
      ][32m+][0m][0m arn                   = (known after apply)
      ][32m+][0m][0m assume_role_policy    = (known after apply)
      ][32m+][0m][0m create_date           = (known after apply)
      ][32m+][0m][0m force_detach_policies = false
      ][32m+][0m][0m id                    = (known after apply)
      ][32m+][0m][0m managed_policy_arns   = (known after apply)
      ][32m+][0m][0m max_session_duration  = 3600
      ][32m+][0m][0m name                  = "finpay-payment-api-role"
      ][32m+][0m][0m name_prefix           = (known after apply)
      ][32m+][0m][0m path                  = "/"
      ][32m+][0m][0m tags                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-payment-api-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-payment-api-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m unique_id             = (known after apply)

      ][32m+][0m][0m inline_policy (known after apply)
    }

][1m  # module.iam_irsa.aws_iam_role.payment_worker[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role" "payment_worker" {
      ][32m+][0m][0m arn                   = (known after apply)
      ][32m+][0m][0m assume_role_policy    = (known after apply)
      ][32m+][0m][0m create_date           = (known after apply)
      ][32m+][0m][0m force_detach_policies = false
      ][32m+][0m][0m id                    = (known after apply)
      ][32m+][0m][0m managed_policy_arns   = (known after apply)
      ][32m+][0m][0m max_session_duration  = 3600
      ][32m+][0m][0m name                  = "finpay-payment-worker-role"
      ][32m+][0m][0m name_prefix           = (known after apply)
      ][32m+][0m][0m path                  = "/"
      ][32m+][0m][0m tags                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-payment-worker-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-payment-worker-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m unique_id             = (known after apply)

      ][32m+][0m][0m inline_policy (known after apply)
    }

][1m  # module.iam_irsa.aws_iam_role_policy_attachment.alb_controller[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "alb_controller" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = (known after apply)
      ][32m+][0m][0m role       = "finpay-alb-controller-role"
    }

][1m  # module.iam_irsa.aws_iam_role_policy_attachment.eks_cluster_policy][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
      ][32m+][0m][0m role       = "finpay-eks-cluster-role"
    }

][1m  # module.iam_irsa.aws_iam_role_policy_attachment.eks_cni_policy][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      ][32m+][0m][0m role       = "finpay-eks-node-role"
    }

][1m  # module.iam_irsa.aws_iam_role_policy_attachment.eks_container_registry_policy][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "eks_container_registry_policy" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ][32m+][0m][0m role       = "finpay-eks-node-role"
    }

][1m  # module.iam_irsa.aws_iam_role_policy_attachment.eks_vpc_resource_controller][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
      ][32m+][0m][0m role       = "finpay-eks-cluster-role"
    }

][1m  # module.iam_irsa.aws_iam_role_policy_attachment.eks_worker_node_policy][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
      ][32m+][0m][0m role       = "finpay-eks-node-role"
    }

][1m  # module.iam_irsa.aws_iam_role_policy_attachment.node_cloudwatch_logs][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "node_cloudwatch_logs" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = (known after apply)
      ][32m+][0m][0m role       = "finpay-eks-node-role"
    }

][1m  # module.iam_irsa.aws_iam_role_policy_attachment.payment_api_secrets[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "payment_api_secrets" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = (known after apply)
      ][32m+][0m][0m role       = "finpay-payment-api-role"
    }

][1m  # module.iam_irsa.aws_iam_role_policy_attachment.payment_worker_cloudwatch[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "payment_worker_cloudwatch" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = (known after apply)
      ][32m+][0m][0m role       = "finpay-payment-worker-role"
    }

][1m  # module.rds.aws_db_instance.main][0m will be created
][0m  ][32m+][0m][0m resource "aws_db_instance" "main" {
      ][32m+][0m][0m address                               = (known after apply)
      ][32m+][0m][0m allocated_storage                     = 100
      ][32m+][0m][0m apply_immediately                     = false
      ][32m+][0m][0m arn                                   = (known after apply)
      ][32m+][0m][0m auto_minor_version_upgrade            = false
      ][32m+][0m][0m availability_zone                     = (known after apply)
      ][32m+][0m][0m backup_retention_period               = 7
      ][32m+][0m][0m backup_target                         = (known after apply)
      ][32m+][0m][0m backup_window                         = "03:00-04:00"
      ][32m+][0m][0m ca_cert_identifier                    = (known after apply)
      ][32m+][0m][0m character_set_name                    = (known after apply)
      ][32m+][0m][0m copy_tags_to_snapshot                 = false
      ][32m+][0m][0m database_insights_mode                = (known after apply)
      ][32m+][0m][0m db_name                               = "paymentdb"
      ][32m+][0m][0m db_subnet_group_name                  = "finpay-db-subnet-group"
      ][32m+][0m][0m dedicated_log_volume                  = false
      ][32m+][0m][0m delete_automated_backups              = true
      ][32m+][0m][0m deletion_protection                   = true
      ][32m+][0m][0m domain_fqdn                           = (known after apply)
      ][32m+][0m][0m enabled_cloudwatch_logs_exports       = [
          ][32m+][0m][0m "postgresql",
          ][32m+][0m][0m "upgrade",
        ]
      ][32m+][0m][0m endpoint                              = (known after apply)
      ][32m+][0m][0m engine                                = "postgres"
      ][32m+][0m][0m engine_lifecycle_support              = (known after apply)
      ][32m+][0m][0m engine_version                        = "16.1"
      ][32m+][0m][0m engine_version_actual                 = (known after apply)
      ][32m+][0m][0m final_snapshot_identifier             = (known after apply)
      ][32m+][0m][0m hosted_zone_id                        = (known after apply)
      ][32m+][0m][0m id                                    = (known after apply)
      ][32m+][0m][0m identifier                            = "finpay-db"
      ][32m+][0m][0m identifier_prefix                     = (known after apply)
      ][32m+][0m][0m instance_class                        = "db.t3.medium"
      ][32m+][0m][0m iops                                  = 3000
      ][32m+][0m][0m kms_key_id                            = (known after apply)
      ][32m+][0m][0m latest_restorable_time                = (known after apply)
      ][32m+][0m][0m license_model                         = (known after apply)
      ][32m+][0m][0m listener_endpoint                     = (known after apply)
      ][32m+][0m][0m maintenance_window                    = "sun:04:00-sun:05:00"
      ][32m+][0m][0m master_user_secret                    = (known after apply)
      ][32m+][0m][0m master_user_secret_kms_key_id         = (known after apply)
      ][32m+][0m][0m monitoring_interval                   = 60
      ][32m+][0m][0m monitoring_role_arn                   = (known after apply)
      ][32m+][0m][0m multi_az                              = true
      ][32m+][0m][0m nchar_character_set_name              = (known after apply)
      ][32m+][0m][0m network_type                          = (known after apply)
      ][32m+][0m][0m option_group_name                     = (known after apply)
      ][32m+][0m][0m parameter_group_name                  = "finpay-db-params"
      ][32m+][0m][0m password                              = (sensitive value)
      ][32m+][0m][0m password_wo                           = (write-only attribute)
      ][32m+][0m][0m performance_insights_enabled          = true
      ][32m+][0m][0m performance_insights_kms_key_id       = (known after apply)
      ][32m+][0m][0m performance_insights_retention_period = 7
      ][32m+][0m][0m port                                  = (known after apply)
      ][32m+][0m][0m publicly_accessible                   = false
      ][32m+][0m][0m replica_mode                          = (known after apply)
      ][32m+][0m][0m replicas                              = (known after apply)
      ][32m+][0m][0m resource_id                           = (known after apply)
      ][32m+][0m][0m skip_final_snapshot                   = false
      ][32m+][0m][0m snapshot_identifier                   = (known after apply)
      ][32m+][0m][0m status                                = (known after apply)
      ][32m+][0m][0m storage_encrypted                     = true
      ][32m+][0m][0m storage_throughput                    = (known after apply)
      ][32m+][0m][0m storage_type                          = "gp3"
      ][32m+][0m][0m tags                                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-db"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-db"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m timezone                              = (known after apply)
      ][32m+][0m][0m username                              = "dbadmin"
      ][32m+][0m][0m vpc_security_group_ids                = (known after apply)
    }

][1m  # module.rds.aws_db_parameter_group.main][0m will be created
][0m  ][32m+][0m][0m resource "aws_db_parameter_group" "main" {
      ][32m+][0m][0m arn          = (known after apply)
      ][32m+][0m][0m description  = "Managed by Terraform"
      ][32m+][0m][0m family       = "postgres16"
      ][32m+][0m][0m id           = (known after apply)
      ][32m+][0m][0m name         = "finpay-db-params"
      ][32m+][0m][0m name_prefix  = (known after apply)
      ][32m+][0m][0m skip_destroy = false
      ][32m+][0m][0m tags         = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-db-params"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all     = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-db-params"
          ][32m+][0m][0m "Project"     = "finpay"
        }

      ][32m+][0m][0m parameter {
          ][32m+][0m][0m apply_method = "immediate"
          ][32m+][0m][0m name         = "log_min_duration_statement"
          ][32m+][0m][0m value        = "1000"
        }
      ][32m+][0m][0m parameter {
          ][32m+][0m][0m apply_method = "immediate"
          ][32m+][0m][0m name         = "log_statement"
          ][32m+][0m][0m value        = "all"
        }
      ][32m+][0m][0m parameter {
          ][32m+][0m][0m apply_method = "immediate"
          ][32m+][0m][0m name         = "shared_preload_libraries"
          ][32m+][0m][0m value        = "pg_stat_statements"
        }
    }

][1m  # module.rds.aws_iam_role.rds_monitoring[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role" "rds_monitoring" {
      ][32m+][0m][0m arn                   = (known after apply)
      ][32m+][0m][0m assume_role_policy    = jsonencode(
            {
              ][32m+][0m][0m Statement = [
                  ][32m+][0m][0m {
                      ][32m+][0m][0m Action    = "sts:AssumeRole"
                      ][32m+][0m][0m Effect    = "Allow"
                      ][32m+][0m][0m Principal = {
                          ][32m+][0m][0m Service = "monitoring.rds.amazonaws.com"
                        }
                    },
                ]
              ][32m+][0m][0m Version   = "2012-10-17"
            }
        )
      ][32m+][0m][0m create_date           = (known after apply)
      ][32m+][0m][0m force_detach_policies = false
      ][32m+][0m][0m id                    = (known after apply)
      ][32m+][0m][0m managed_policy_arns   = (known after apply)
      ][32m+][0m][0m max_session_duration  = 3600
      ][32m+][0m][0m name                  = "finpay-rds-monitoring-role"
      ][32m+][0m][0m name_prefix           = (known after apply)
      ][32m+][0m][0m path                  = "/"
      ][32m+][0m][0m tags                  = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-rds-monitoring-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all              = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-rds-monitoring-role"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m unique_id             = (known after apply)

      ][32m+][0m][0m inline_policy (known after apply)
    }

][1m  # module.rds.aws_iam_role_policy_attachment.rds_monitoring[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_iam_role_policy_attachment" "rds_monitoring" {
      ][32m+][0m][0m id         = (known after apply)
      ][32m+][0m][0m policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
      ][32m+][0m][0m role       = "finpay-rds-monitoring-role"
    }

][1m  # module.rds.random_password.db_password][0m will be created
][0m  ][32m+][0m][0m resource "random_password" "db_password" {
      ][32m+][0m][0m bcrypt_hash      = (sensitive value)
      ][32m+][0m][0m id               = (known after apply)
      ][32m+][0m][0m length           = 32
      ][32m+][0m][0m lower            = true
      ][32m+][0m][0m min_lower        = 0
      ][32m+][0m][0m min_numeric      = 0
      ][32m+][0m][0m min_special      = 0
      ][32m+][0m][0m min_upper        = 0
      ][32m+][0m][0m number           = true
      ][32m+][0m][0m numeric          = true
      ][32m+][0m][0m override_special = "!#$%&*()-_=+[]{}<>:?"
      ][32m+][0m][0m result           = (sensitive value)
      ][32m+][0m][0m special          = true
      ][32m+][0m][0m upper            = true
    }

][1m  # module.secrets.aws_secretsmanager_secret.app_config][0m will be created
][0m  ][32m+][0m][0m resource "aws_secretsmanager_secret" "app_config" {
      ][32m+][0m][0m arn                            = (known after apply)
      ][32m+][0m][0m description                    = "Application configuration for finpay"
      ][32m+][0m][0m force_overwrite_replica_secret = false
      ][32m+][0m][0m id                             = (known after apply)
      ][32m+][0m][0m name                           = "finpay/app/config"
      ][32m+][0m][0m name_prefix                    = (known after apply)
      ][32m+][0m][0m policy                         = (known after apply)
      ][32m+][0m][0m recovery_window_in_days        = 30
      ][32m+][0m][0m tags                           = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-app-config"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                       = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-app-config"
          ][32m+][0m][0m "Project"     = "finpay"
        }

      ][32m+][0m][0m replica (known after apply)
    }

][1m  # module.secrets.aws_secretsmanager_secret.db_credentials][0m will be created
][0m  ][32m+][0m][0m resource "aws_secretsmanager_secret" "db_credentials" {
      ][32m+][0m][0m arn                            = (known after apply)
      ][32m+][0m][0m description                    = "Database credentials for finpay"
      ][32m+][0m][0m force_overwrite_replica_secret = false
      ][32m+][0m][0m id                             = (known after apply)
      ][32m+][0m][0m name                           = "finpay/database/credentials"
      ][32m+][0m][0m name_prefix                    = (known after apply)
      ][32m+][0m][0m policy                         = (known after apply)
      ][32m+][0m][0m recovery_window_in_days        = 30
      ][32m+][0m][0m tags                           = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-db-credentials"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                       = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-db-credentials"
          ][32m+][0m][0m "Project"     = "finpay"
        }

      ][32m+][0m][0m replica (known after apply)
    }

][1m  # module.secrets.aws_secretsmanager_secret_version.app_config][0m will be created
][0m  ][32m+][0m][0m resource "aws_secretsmanager_secret_version" "app_config" {
      ][32m+][0m][0m arn                  = (known after apply)
      ][32m+][0m][0m has_secret_string_wo = (known after apply)
      ][32m+][0m][0m id                   = (known after apply)
      ][32m+][0m][0m secret_id            = (known after apply)
      ][32m+][0m][0m secret_string        = (sensitive value)
      ][32m+][0m][0m secret_string_wo     = (write-only attribute)
      ][32m+][0m][0m version_id           = (known after apply)
      ][32m+][0m][0m version_stages       = (known after apply)
    }

][1m  # module.secrets.aws_secretsmanager_secret_version.db_credentials][0m will be created
][0m  ][32m+][0m][0m resource "aws_secretsmanager_secret_version" "db_credentials" {
      ][32m+][0m][0m arn                  = (known after apply)
      ][32m+][0m][0m has_secret_string_wo = (known after apply)
      ][32m+][0m][0m id                   = (known after apply)
      ][32m+][0m][0m secret_id            = (known after apply)
      ][32m+][0m][0m secret_string        = (sensitive value)
      ][32m+][0m][0m secret_string_wo     = (write-only attribute)
      ][32m+][0m][0m version_id           = (known after apply)
      ][32m+][0m][0m version_stages       = (known after apply)
    }

][1m  # module.security_groups.aws_security_group.alb][0m will be created
][0m  ][32m+][0m][0m resource "aws_security_group" "alb" {
      ][32m+][0m][0m arn                    = (known after apply)
      ][32m+][0m][0m description            = "Security group for Application Load Balancer"
      ][32m+][0m][0m egress                 = (known after apply)
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m ingress                = (known after apply)
      ][32m+][0m][0m name                   = "finpay-alb-sg"
      ][32m+][0m][0m name_prefix            = (known after apply)
      ][32m+][0m][0m owner_id               = (known after apply)
      ][32m+][0m][0m revoke_rules_on_delete = false
      ][32m+][0m][0m tags                   = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-alb-sg"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all               = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-alb-sg"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc_id                 = (known after apply)
    }

][1m  # module.security_groups.aws_security_group.eks_control_plane][0m will be created
][0m  ][32m+][0m][0m resource "aws_security_group" "eks_control_plane" {
      ][32m+][0m][0m arn                    = (known after apply)
      ][32m+][0m][0m description            = "Security group for EKS control plane"
      ][32m+][0m][0m egress                 = (known after apply)
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m ingress                = (known after apply)
      ][32m+][0m][0m name                   = "finpay-eks-control-plane-sg"
      ][32m+][0m][0m name_prefix            = (known after apply)
      ][32m+][0m][0m owner_id               = (known after apply)
      ][32m+][0m][0m revoke_rules_on_delete = false
      ][32m+][0m][0m tags                   = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-control-plane-sg"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all               = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-eks-control-plane-sg"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc_id                 = (known after apply)
    }

][1m  # module.security_groups.aws_security_group.eks_nodes][0m will be created
][0m  ][32m+][0m][0m resource "aws_security_group" "eks_nodes" {
      ][32m+][0m][0m arn                    = (known after apply)
      ][32m+][0m][0m description            = "Security group for EKS worker nodes"
      ][32m+][0m][0m egress                 = (known after apply)
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m ingress                = (known after apply)
      ][32m+][0m][0m name                   = "finpay-eks-nodes-sg"
      ][32m+][0m][0m name_prefix            = (known after apply)
      ][32m+][0m][0m owner_id               = (known after apply)
      ][32m+][0m][0m revoke_rules_on_delete = false
      ][32m+][0m][0m tags                   = {
          ][32m+][0m][0m "Environment"                                 = "production"
          ][32m+][0m][0m "ManagedBy"                                   = "Terraform"
          ][32m+][0m][0m "Name"                                        = "finpay-eks-nodes-sg"
          ][32m+][0m][0m "Project"                                     = "finpay"
          ][32m+][0m][0m "kubernetes.io/cluster/finpay-production-eks" = "owned"
        }
      ][32m+][0m][0m tags_all               = {
          ][32m+][0m][0m "Environment"                                 = "production"
          ][32m+][0m][0m "ManagedBy"                                   = "Terraform"
          ][32m+][0m][0m "Name"                                        = "finpay-eks-nodes-sg"
          ][32m+][0m][0m "Project"                                     = "finpay"
          ][32m+][0m][0m "kubernetes.io/cluster/finpay-production-eks" = "owned"
        }
      ][32m+][0m][0m vpc_id                 = (known after apply)
    }

][1m  # module.security_groups.aws_security_group.rds][0m will be created
][0m  ][32m+][0m][0m resource "aws_security_group" "rds" {
      ][32m+][0m][0m arn                    = (known after apply)
      ][32m+][0m][0m description            = "Security group for RDS PostgreSQL"
      ][32m+][0m][0m egress                 = (known after apply)
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m ingress                = (known after apply)
      ][32m+][0m][0m name                   = "finpay-rds-sg"
      ][32m+][0m][0m name_prefix            = (known after apply)
      ][32m+][0m][0m owner_id               = (known after apply)
      ][32m+][0m][0m revoke_rules_on_delete = false
      ][32m+][0m][0m tags                   = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-rds-sg"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all               = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-rds-sg"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc_id                 = (known after apply)
    }

][1m  # module.security_groups.aws_vpc_security_group_egress_rule.alb_to_eks][0m will be created
][0m  ][32m+][0m][0m resource "aws_vpc_security_group_egress_rule" "alb_to_eks" {
      ][32m+][0m][0m arn                          = (known after apply)
      ][32m+][0m][0m description                  = "Allow traffic to EKS nodes"
      ][32m+][0m][0m id                           = (known after apply)
      ][32m+][0m][0m ip_protocol                  = "-1"
      ][32m+][0m][0m referenced_security_group_id = (known after apply)
      ][32m+][0m][0m security_group_id            = (known after apply)
      ][32m+][0m][0m security_group_rule_id       = (known after apply)
      ][32m+][0m][0m tags_all                     = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.security_groups.aws_vpc_security_group_egress_rule.control_plane_to_nodes][0m will be created
][0m  ][32m+][0m][0m resource "aws_vpc_security_group_egress_rule" "control_plane_to_nodes" {
      ][32m+][0m][0m arn                          = (known after apply)
      ][32m+][0m][0m description                  = "Allow traffic to worker nodes"
      ][32m+][0m][0m id                           = (known after apply)
      ][32m+][0m][0m ip_protocol                  = "-1"
      ][32m+][0m][0m referenced_security_group_id = (known after apply)
      ][32m+][0m][0m security_group_id            = (known after apply)
      ][32m+][0m][0m security_group_rule_id       = (known after apply)
      ][32m+][0m][0m tags_all                     = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.security_groups.aws_vpc_security_group_egress_rule.eks_nodes_egress][0m will be created
][0m  ][32m+][0m][0m resource "aws_vpc_security_group_egress_rule" "eks_nodes_egress" {
      ][32m+][0m][0m arn                    = (known after apply)
      ][32m+][0m][0m cidr_ipv4              = "0.0.0.0/0"
      ][32m+][0m][0m description            = "Allow all outbound traffic"
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m ip_protocol            = "-1"
      ][32m+][0m][0m security_group_id      = (known after apply)
      ][32m+][0m][0m security_group_rule_id = (known after apply)
      ][32m+][0m][0m tags_all               = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.security_groups.aws_vpc_security_group_ingress_rule.alb_http][0m will be created
][0m  ][32m+][0m][0m resource "aws_vpc_security_group_ingress_rule" "alb_http" {
      ][32m+][0m][0m arn                    = (known after apply)
      ][32m+][0m][0m cidr_ipv4              = "0.0.0.0/0"
      ][32m+][0m][0m description            = "Allow HTTP from anywhere"
      ][32m+][0m][0m from_port              = 80
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m ip_protocol            = "tcp"
      ][32m+][0m][0m security_group_id      = (known after apply)
      ][32m+][0m][0m security_group_rule_id = (known after apply)
      ][32m+][0m][0m tags_all               = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m to_port                = 80
    }

][1m  # module.security_groups.aws_vpc_security_group_ingress_rule.alb_https][0m will be created
][0m  ][32m+][0m][0m resource "aws_vpc_security_group_ingress_rule" "alb_https" {
      ][32m+][0m][0m arn                    = (known after apply)
      ][32m+][0m][0m cidr_ipv4              = "0.0.0.0/0"
      ][32m+][0m][0m description            = "Allow HTTPS from anywhere"
      ][32m+][0m][0m from_port              = 443
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m ip_protocol            = "tcp"
      ][32m+][0m][0m security_group_id      = (known after apply)
      ][32m+][0m][0m security_group_rule_id = (known after apply)
      ][32m+][0m][0m tags_all               = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m to_port                = 443
    }

][1m  # module.security_groups.aws_vpc_security_group_ingress_rule.control_plane_from_nodes][0m will be created
][0m  ][32m+][0m][0m resource "aws_vpc_security_group_ingress_rule" "control_plane_from_nodes" {
      ][32m+][0m][0m arn                          = (known after apply)
      ][32m+][0m][0m description                  = "Allow traffic from worker nodes"
      ][32m+][0m][0m from_port                    = 443
      ][32m+][0m][0m id                           = (known after apply)
      ][32m+][0m][0m ip_protocol                  = "tcp"
      ][32m+][0m][0m referenced_security_group_id = (known after apply)
      ][32m+][0m][0m security_group_id            = (known after apply)
      ][32m+][0m][0m security_group_rule_id       = (known after apply)
      ][32m+][0m][0m tags_all                     = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m to_port                      = 443
    }

][1m  # module.security_groups.aws_vpc_security_group_ingress_rule.eks_from_alb][0m will be created
][0m  ][32m+][0m][0m resource "aws_vpc_security_group_ingress_rule" "eks_from_alb" {
      ][32m+][0m][0m arn                          = (known after apply)
      ][32m+][0m][0m description                  = "Allow traffic from ALB"
      ][32m+][0m][0m id                           = (known after apply)
      ][32m+][0m][0m ip_protocol                  = "-1"
      ][32m+][0m][0m referenced_security_group_id = (known after apply)
      ][32m+][0m][0m security_group_id            = (known after apply)
      ][32m+][0m][0m security_group_rule_id       = (known after apply)
      ][32m+][0m][0m tags_all                     = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.security_groups.aws_vpc_security_group_ingress_rule.eks_from_control_plane][0m will be created
][0m  ][32m+][0m][0m resource "aws_vpc_security_group_ingress_rule" "eks_from_control_plane" {
      ][32m+][0m][0m arn                          = (known after apply)
      ][32m+][0m][0m description                  = "Allow traffic from EKS control plane"
      ][32m+][0m][0m id                           = (known after apply)
      ][32m+][0m][0m ip_protocol                  = "-1"
      ][32m+][0m][0m referenced_security_group_id = (known after apply)
      ][32m+][0m][0m security_group_id            = (known after apply)
      ][32m+][0m][0m security_group_rule_id       = (known after apply)
      ][32m+][0m][0m tags_all                     = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.security_groups.aws_vpc_security_group_ingress_rule.eks_inter_node][0m will be created
][0m  ][32m+][0m][0m resource "aws_vpc_security_group_ingress_rule" "eks_inter_node" {
      ][32m+][0m][0m arn                          = (known after apply)
      ][32m+][0m][0m description                  = "Allow inter-node communication"
      ][32m+][0m][0m id                           = (known after apply)
      ][32m+][0m][0m ip_protocol                  = "-1"
      ][32m+][0m][0m referenced_security_group_id = (known after apply)
      ][32m+][0m][0m security_group_id            = (known after apply)
      ][32m+][0m][0m security_group_rule_id       = (known after apply)
      ][32m+][0m][0m tags_all                     = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.security_groups.aws_vpc_security_group_ingress_rule.rds_from_eks][0m will be created
][0m  ][32m+][0m][0m resource "aws_vpc_security_group_ingress_rule" "rds_from_eks" {
      ][32m+][0m][0m arn                          = (known after apply)
      ][32m+][0m][0m description                  = "Allow PostgreSQL from EKS nodes"
      ][32m+][0m][0m from_port                    = 5432
      ][32m+][0m][0m id                           = (known after apply)
      ][32m+][0m][0m ip_protocol                  = "tcp"
      ][32m+][0m][0m referenced_security_group_id = (known after apply)
      ][32m+][0m][0m security_group_id            = (known after apply)
      ][32m+][0m][0m security_group_rule_id       = (known after apply)
      ][32m+][0m][0m tags_all                     = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m to_port                      = 5432
    }

][1m  # module.vpc.aws_db_subnet_group.main][0m will be created
][0m  ][32m+][0m][0m resource "aws_db_subnet_group" "main" {
      ][32m+][0m][0m arn                     = (known after apply)
      ][32m+][0m][0m description             = "Managed by Terraform"
      ][32m+][0m][0m id                      = (known after apply)
      ][32m+][0m][0m name                    = "finpay-db-subnet-group"
      ][32m+][0m][0m name_prefix             = (known after apply)
      ][32m+][0m][0m subnet_ids              = (known after apply)
      ][32m+][0m][0m supported_network_types = (known after apply)
      ][32m+][0m][0m tags                    = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-db-subnet-group"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-db-subnet-group"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc_id                  = (known after apply)
    }

][1m  # module.vpc.aws_eip.nat[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_eip" "nat" {
      ][32m+][0m][0m allocation_id        = (known after apply)
      ][32m+][0m][0m arn                  = (known after apply)
      ][32m+][0m][0m association_id       = (known after apply)
      ][32m+][0m][0m carrier_ip           = (known after apply)
      ][32m+][0m][0m customer_owned_ip    = (known after apply)
      ][32m+][0m][0m domain               = "vpc"
      ][32m+][0m][0m id                   = (known after apply)
      ][32m+][0m][0m instance             = (known after apply)
      ][32m+][0m][0m ipam_pool_id         = (known after apply)
      ][32m+][0m][0m network_border_group = (known after apply)
      ][32m+][0m][0m network_interface    = (known after apply)
      ][32m+][0m][0m private_dns          = (known after apply)
      ][32m+][0m][0m private_ip           = (known after apply)
      ][32m+][0m][0m ptr_record           = (known after apply)
      ][32m+][0m][0m public_dns           = (known after apply)
      ][32m+][0m][0m public_ip            = (known after apply)
      ][32m+][0m][0m public_ipv4_pool     = (known after apply)
      ][32m+][0m][0m tags                 = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-nat-eip-eu-central-1a"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-nat-eip-eu-central-1a"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc                  = (known after apply)
    }

][1m  # module.vpc.aws_eip.nat[1]][0m will be created
][0m  ][32m+][0m][0m resource "aws_eip" "nat" {
      ][32m+][0m][0m allocation_id        = (known after apply)
      ][32m+][0m][0m arn                  = (known after apply)
      ][32m+][0m][0m association_id       = (known after apply)
      ][32m+][0m][0m carrier_ip           = (known after apply)
      ][32m+][0m][0m customer_owned_ip    = (known after apply)
      ][32m+][0m][0m domain               = "vpc"
      ][32m+][0m][0m id                   = (known after apply)
      ][32m+][0m][0m instance             = (known after apply)
      ][32m+][0m][0m ipam_pool_id         = (known after apply)
      ][32m+][0m][0m network_border_group = (known after apply)
      ][32m+][0m][0m network_interface    = (known after apply)
      ][32m+][0m][0m private_dns          = (known after apply)
      ][32m+][0m][0m private_ip           = (known after apply)
      ][32m+][0m][0m ptr_record           = (known after apply)
      ][32m+][0m][0m public_dns           = (known after apply)
      ][32m+][0m][0m public_ip            = (known after apply)
      ][32m+][0m][0m public_ipv4_pool     = (known after apply)
      ][32m+][0m][0m tags                 = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-nat-eip-eu-central-1b"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-nat-eip-eu-central-1b"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc                  = (known after apply)
    }

][1m  # module.vpc.aws_internet_gateway.main][0m will be created
][0m  ][32m+][0m][0m resource "aws_internet_gateway" "main" {
      ][32m+][0m][0m arn      = (known after apply)
      ][32m+][0m][0m id       = (known after apply)
      ][32m+][0m][0m owner_id = (known after apply)
      ][32m+][0m][0m tags     = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-igw"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-igw"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc_id   = (known after apply)
    }

][1m  # module.vpc.aws_nat_gateway.main[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_nat_gateway" "main" {
      ][32m+][0m][0m allocation_id                      = (known after apply)
      ][32m+][0m][0m association_id                     = (known after apply)
      ][32m+][0m][0m connectivity_type                  = "public"
      ][32m+][0m][0m id                                 = (known after apply)
      ][32m+][0m][0m network_interface_id               = (known after apply)
      ][32m+][0m][0m private_ip                         = (known after apply)
      ][32m+][0m][0m public_ip                          = (known after apply)
      ][32m+][0m][0m secondary_private_ip_address_count = (known after apply)
      ][32m+][0m][0m secondary_private_ip_addresses     = (known after apply)
      ][32m+][0m][0m subnet_id                          = (known after apply)
      ][32m+][0m][0m tags                               = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-nat-eu-central-1a"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                           = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-nat-eu-central-1a"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.vpc.aws_nat_gateway.main[1]][0m will be created
][0m  ][32m+][0m][0m resource "aws_nat_gateway" "main" {
      ][32m+][0m][0m allocation_id                      = (known after apply)
      ][32m+][0m][0m association_id                     = (known after apply)
      ][32m+][0m][0m connectivity_type                  = "public"
      ][32m+][0m][0m id                                 = (known after apply)
      ][32m+][0m][0m network_interface_id               = (known after apply)
      ][32m+][0m][0m private_ip                         = (known after apply)
      ][32m+][0m][0m public_ip                          = (known after apply)
      ][32m+][0m][0m secondary_private_ip_address_count = (known after apply)
      ][32m+][0m][0m secondary_private_ip_addresses     = (known after apply)
      ][32m+][0m][0m subnet_id                          = (known after apply)
      ][32m+][0m][0m tags                               = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-nat-eu-central-1b"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                           = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-nat-eu-central-1b"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1m  # module.vpc.aws_route.private_nat[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_route" "private_nat" {
      ][32m+][0m][0m destination_cidr_block = "0.0.0.0/0"
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m instance_id            = (known after apply)
      ][32m+][0m][0m instance_owner_id      = (known after apply)
      ][32m+][0m][0m nat_gateway_id         = (known after apply)
      ][32m+][0m][0m network_interface_id   = (known after apply)
      ][32m+][0m][0m origin                 = (known after apply)
      ][32m+][0m][0m route_table_id         = (known after apply)
      ][32m+][0m][0m state                  = (known after apply)
    }

][1m  # module.vpc.aws_route.private_nat[1]][0m will be created
][0m  ][32m+][0m][0m resource "aws_route" "private_nat" {
      ][32m+][0m][0m destination_cidr_block = "0.0.0.0/0"
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m instance_id            = (known after apply)
      ][32m+][0m][0m instance_owner_id      = (known after apply)
      ][32m+][0m][0m nat_gateway_id         = (known after apply)
      ][32m+][0m][0m network_interface_id   = (known after apply)
      ][32m+][0m][0m origin                 = (known after apply)
      ][32m+][0m][0m route_table_id         = (known after apply)
      ][32m+][0m][0m state                  = (known after apply)
    }

][1m  # module.vpc.aws_route.public_internet][0m will be created
][0m  ][32m+][0m][0m resource "aws_route" "public_internet" {
      ][32m+][0m][0m destination_cidr_block = "0.0.0.0/0"
      ][32m+][0m][0m gateway_id             = (known after apply)
      ][32m+][0m][0m id                     = (known after apply)
      ][32m+][0m][0m instance_id            = (known after apply)
      ][32m+][0m][0m instance_owner_id      = (known after apply)
      ][32m+][0m][0m network_interface_id   = (known after apply)
      ][32m+][0m][0m origin                 = (known after apply)
      ][32m+][0m][0m route_table_id         = (known after apply)
      ][32m+][0m][0m state                  = (known after apply)
    }

][1m  # module.vpc.aws_route_table.database][0m will be created
][0m  ][32m+][0m][0m resource "aws_route_table" "database" {
      ][32m+][0m][0m arn              = (known after apply)
      ][32m+][0m][0m id               = (known after apply)
      ][32m+][0m][0m owner_id         = (known after apply)
      ][32m+][0m][0m propagating_vgws = (known after apply)
      ][32m+][0m][0m route            = (known after apply)
      ][32m+][0m][0m tags             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-database-rt"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all         = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-database-rt"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc_id           = (known after apply)
    }

][1m  # module.vpc.aws_route_table.private[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_route_table" "private" {
      ][32m+][0m][0m arn              = (known after apply)
      ][32m+][0m][0m id               = (known after apply)
      ][32m+][0m][0m owner_id         = (known after apply)
      ][32m+][0m][0m propagating_vgws = (known after apply)
      ][32m+][0m][0m route            = (known after apply)
      ][32m+][0m][0m tags             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-private-rt-eu-central-1a"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all         = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-private-rt-eu-central-1a"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc_id           = (known after apply)
    }

][1m  # module.vpc.aws_route_table.private[1]][0m will be created
][0m  ][32m+][0m][0m resource "aws_route_table" "private" {
      ][32m+][0m][0m arn              = (known after apply)
      ][32m+][0m][0m id               = (known after apply)
      ][32m+][0m][0m owner_id         = (known after apply)
      ][32m+][0m][0m propagating_vgws = (known after apply)
      ][32m+][0m][0m route            = (known after apply)
      ][32m+][0m][0m tags             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-private-rt-eu-central-1b"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all         = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-private-rt-eu-central-1b"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc_id           = (known after apply)
    }

][1m  # module.vpc.aws_route_table.public][0m will be created
][0m  ][32m+][0m][0m resource "aws_route_table" "public" {
      ][32m+][0m][0m arn              = (known after apply)
      ][32m+][0m][0m id               = (known after apply)
      ][32m+][0m][0m owner_id         = (known after apply)
      ][32m+][0m][0m propagating_vgws = (known after apply)
      ][32m+][0m][0m route            = (known after apply)
      ][32m+][0m][0m tags             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-public-rt"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all         = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-public-rt"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc_id           = (known after apply)
    }

][1m  # module.vpc.aws_route_table_association.database[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_route_table_association" "database" {
      ][32m+][0m][0m id             = (known after apply)
      ][32m+][0m][0m route_table_id = (known after apply)
      ][32m+][0m][0m subnet_id      = (known after apply)
    }

][1m  # module.vpc.aws_route_table_association.database[1]][0m will be created
][0m  ][32m+][0m][0m resource "aws_route_table_association" "database" {
      ][32m+][0m][0m id             = (known after apply)
      ][32m+][0m][0m route_table_id = (known after apply)
      ][32m+][0m][0m subnet_id      = (known after apply)
    }

][1m  # module.vpc.aws_route_table_association.private[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_route_table_association" "private" {
      ][32m+][0m][0m id             = (known after apply)
      ][32m+][0m][0m route_table_id = (known after apply)
      ][32m+][0m][0m subnet_id      = (known after apply)
    }

][1m  # module.vpc.aws_route_table_association.private[1]][0m will be created
][0m  ][32m+][0m][0m resource "aws_route_table_association" "private" {
      ][32m+][0m][0m id             = (known after apply)
      ][32m+][0m][0m route_table_id = (known after apply)
      ][32m+][0m][0m subnet_id      = (known after apply)
    }

][1m  # module.vpc.aws_route_table_association.public[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_route_table_association" "public" {
      ][32m+][0m][0m id             = (known after apply)
      ][32m+][0m][0m route_table_id = (known after apply)
      ][32m+][0m][0m subnet_id      = (known after apply)
    }

][1m  # module.vpc.aws_route_table_association.public[1]][0m will be created
][0m  ][32m+][0m][0m resource "aws_route_table_association" "public" {
      ][32m+][0m][0m id             = (known after apply)
      ][32m+][0m][0m route_table_id = (known after apply)
      ][32m+][0m][0m subnet_id      = (known after apply)
    }

][1m  # module.vpc.aws_subnet.database[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_subnet" "database" {
      ][32m+][0m][0m arn                                            = (known after apply)
      ][32m+][0m][0m assign_ipv6_address_on_creation                = false
      ][32m+][0m][0m availability_zone                              = "eu-central-1a"
      ][32m+][0m][0m availability_zone_id                           = (known after apply)
      ][32m+][0m][0m cidr_block                                     = "10.0.20.0/24"
      ][32m+][0m][0m enable_dns64                                   = false
      ][32m+][0m][0m enable_resource_name_dns_a_record_on_launch    = false
      ][32m+][0m][0m enable_resource_name_dns_aaaa_record_on_launch = false
      ][32m+][0m][0m id                                             = (known after apply)
      ][32m+][0m][0m ipv6_cidr_block_association_id                 = (known after apply)
      ][32m+][0m][0m ipv6_native                                    = false
      ][32m+][0m][0m map_public_ip_on_launch                        = false
      ][32m+][0m][0m owner_id                                       = (known after apply)
      ][32m+][0m][0m private_dns_hostname_type_on_launch            = (known after apply)
      ][32m+][0m][0m tags                                           = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-database-eu-central-1a"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                                       = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-database-eu-central-1a"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc_id                                         = (known after apply)
    }

][1m  # module.vpc.aws_subnet.database[1]][0m will be created
][0m  ][32m+][0m][0m resource "aws_subnet" "database" {
      ][32m+][0m][0m arn                                            = (known after apply)
      ][32m+][0m][0m assign_ipv6_address_on_creation                = false
      ][32m+][0m][0m availability_zone                              = "eu-central-1b"
      ][32m+][0m][0m availability_zone_id                           = (known after apply)
      ][32m+][0m][0m cidr_block                                     = "10.0.21.0/24"
      ][32m+][0m][0m enable_dns64                                   = false
      ][32m+][0m][0m enable_resource_name_dns_a_record_on_launch    = false
      ][32m+][0m][0m enable_resource_name_dns_aaaa_record_on_launch = false
      ][32m+][0m][0m id                                             = (known after apply)
      ][32m+][0m][0m ipv6_cidr_block_association_id                 = (known after apply)
      ][32m+][0m][0m ipv6_native                                    = false
      ][32m+][0m][0m map_public_ip_on_launch                        = false
      ][32m+][0m][0m owner_id                                       = (known after apply)
      ][32m+][0m][0m private_dns_hostname_type_on_launch            = (known after apply)
      ][32m+][0m][0m tags                                           = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-database-eu-central-1b"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                                       = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-database-eu-central-1b"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m vpc_id                                         = (known after apply)
    }

][1m  # module.vpc.aws_subnet.private[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_subnet" "private" {
      ][32m+][0m][0m arn                                            = (known after apply)
      ][32m+][0m][0m assign_ipv6_address_on_creation                = false
      ][32m+][0m][0m availability_zone                              = "eu-central-1a"
      ][32m+][0m][0m availability_zone_id                           = (known after apply)
      ][32m+][0m][0m cidr_block                                     = "10.0.10.0/24"
      ][32m+][0m][0m enable_dns64                                   = false
      ][32m+][0m][0m enable_resource_name_dns_a_record_on_launch    = false
      ][32m+][0m][0m enable_resource_name_dns_aaaa_record_on_launch = false
      ][32m+][0m][0m id                                             = (known after apply)
      ][32m+][0m][0m ipv6_cidr_block_association_id                 = (known after apply)
      ][32m+][0m][0m ipv6_native                                    = false
      ][32m+][0m][0m map_public_ip_on_launch                        = false
      ][32m+][0m][0m owner_id                                       = (known after apply)
      ][32m+][0m][0m private_dns_hostname_type_on_launch            = (known after apply)
      ][32m+][0m][0m tags                                           = {
          ][32m+][0m][0m "Environment"                     = "production"
          ][32m+][0m][0m "ManagedBy"                       = "Terraform"
          ][32m+][0m][0m "Name"                            = "finpay-private-eu-central-1a"
          ][32m+][0m][0m "Project"                         = "finpay"
          ][32m+][0m][0m "kubernetes.io/role/internal-elb" = "1"
        }
      ][32m+][0m][0m tags_all                                       = {
          ][32m+][0m][0m "Environment"                     = "production"
          ][32m+][0m][0m "ManagedBy"                       = "Terraform"
          ][32m+][0m][0m "Name"                            = "finpay-private-eu-central-1a"
          ][32m+][0m][0m "Project"                         = "finpay"
          ][32m+][0m][0m "kubernetes.io/role/internal-elb" = "1"
        }
      ][32m+][0m][0m vpc_id                                         = (known after apply)
    }

][1m  # module.vpc.aws_subnet.private[1]][0m will be created
][0m  ][32m+][0m][0m resource "aws_subnet" "private" {
      ][32m+][0m][0m arn                                            = (known after apply)
      ][32m+][0m][0m assign_ipv6_address_on_creation                = false
      ][32m+][0m][0m availability_zone                              = "eu-central-1b"
      ][32m+][0m][0m availability_zone_id                           = (known after apply)
      ][32m+][0m][0m cidr_block                                     = "10.0.11.0/24"
      ][32m+][0m][0m enable_dns64                                   = false
      ][32m+][0m][0m enable_resource_name_dns_a_record_on_launch    = false
      ][32m+][0m][0m enable_resource_name_dns_aaaa_record_on_launch = false
      ][32m+][0m][0m id                                             = (known after apply)
      ][32m+][0m][0m ipv6_cidr_block_association_id                 = (known after apply)
      ][32m+][0m][0m ipv6_native                                    = false
      ][32m+][0m][0m map_public_ip_on_launch                        = false
      ][32m+][0m][0m owner_id                                       = (known after apply)
      ][32m+][0m][0m private_dns_hostname_type_on_launch            = (known after apply)
      ][32m+][0m][0m tags                                           = {
          ][32m+][0m][0m "Environment"                     = "production"
          ][32m+][0m][0m "ManagedBy"                       = "Terraform"
          ][32m+][0m][0m "Name"                            = "finpay-private-eu-central-1b"
          ][32m+][0m][0m "Project"                         = "finpay"
          ][32m+][0m][0m "kubernetes.io/role/internal-elb" = "1"
        }
      ][32m+][0m][0m tags_all                                       = {
          ][32m+][0m][0m "Environment"                     = "production"
          ][32m+][0m][0m "ManagedBy"                       = "Terraform"
          ][32m+][0m][0m "Name"                            = "finpay-private-eu-central-1b"
          ][32m+][0m][0m "Project"                         = "finpay"
          ][32m+][0m][0m "kubernetes.io/role/internal-elb" = "1"
        }
      ][32m+][0m][0m vpc_id                                         = (known after apply)
    }

][1m  # module.vpc.aws_subnet.public[0]][0m will be created
][0m  ][32m+][0m][0m resource "aws_subnet" "public" {
      ][32m+][0m][0m arn                                            = (known after apply)
      ][32m+][0m][0m assign_ipv6_address_on_creation                = false
      ][32m+][0m][0m availability_zone                              = "eu-central-1a"
      ][32m+][0m][0m availability_zone_id                           = (known after apply)
      ][32m+][0m][0m cidr_block                                     = "10.0.1.0/24"
      ][32m+][0m][0m enable_dns64                                   = false
      ][32m+][0m][0m enable_resource_name_dns_a_record_on_launch    = false
      ][32m+][0m][0m enable_resource_name_dns_aaaa_record_on_launch = false
      ][32m+][0m][0m id                                             = (known after apply)
      ][32m+][0m][0m ipv6_cidr_block_association_id                 = (known after apply)
      ][32m+][0m][0m ipv6_native                                    = false
      ][32m+][0m][0m map_public_ip_on_launch                        = true
      ][32m+][0m][0m owner_id                                       = (known after apply)
      ][32m+][0m][0m private_dns_hostname_type_on_launch            = (known after apply)
      ][32m+][0m][0m tags                                           = {
          ][32m+][0m][0m "Environment"            = "production"
          ][32m+][0m][0m "ManagedBy"              = "Terraform"
          ][32m+][0m][0m "Name"                   = "finpay-public-eu-central-1a"
          ][32m+][0m][0m "Project"                = "finpay"
          ][32m+][0m][0m "kubernetes.io/role/elb" = "1"
        }
      ][32m+][0m][0m tags_all                                       = {
          ][32m+][0m][0m "Environment"            = "production"
          ][32m+][0m][0m "ManagedBy"              = "Terraform"
          ][32m+][0m][0m "Name"                   = "finpay-public-eu-central-1a"
          ][32m+][0m][0m "Project"                = "finpay"
          ][32m+][0m][0m "kubernetes.io/role/elb" = "1"
        }
      ][32m+][0m][0m vpc_id                                         = (known after apply)
    }

][1m  # module.vpc.aws_subnet.public[1]][0m will be created
][0m  ][32m+][0m][0m resource "aws_subnet" "public" {
      ][32m+][0m][0m arn                                            = (known after apply)
      ][32m+][0m][0m assign_ipv6_address_on_creation                = false
      ][32m+][0m][0m availability_zone                              = "eu-central-1b"
      ][32m+][0m][0m availability_zone_id                           = (known after apply)
      ][32m+][0m][0m cidr_block                                     = "10.0.2.0/24"
      ][32m+][0m][0m enable_dns64                                   = false
      ][32m+][0m][0m enable_resource_name_dns_a_record_on_launch    = false
      ][32m+][0m][0m enable_resource_name_dns_aaaa_record_on_launch = false
      ][32m+][0m][0m id                                             = (known after apply)
      ][32m+][0m][0m ipv6_cidr_block_association_id                 = (known after apply)
      ][32m+][0m][0m ipv6_native                                    = false
      ][32m+][0m][0m map_public_ip_on_launch                        = true
      ][32m+][0m][0m owner_id                                       = (known after apply)
      ][32m+][0m][0m private_dns_hostname_type_on_launch            = (known after apply)
      ][32m+][0m][0m tags                                           = {
          ][32m+][0m][0m "Environment"            = "production"
          ][32m+][0m][0m "ManagedBy"              = "Terraform"
          ][32m+][0m][0m "Name"                   = "finpay-public-eu-central-1b"
          ][32m+][0m][0m "Project"                = "finpay"
          ][32m+][0m][0m "kubernetes.io/role/elb" = "1"
        }
      ][32m+][0m][0m tags_all                                       = {
          ][32m+][0m][0m "Environment"            = "production"
          ][32m+][0m][0m "ManagedBy"              = "Terraform"
          ][32m+][0m][0m "Name"                   = "finpay-public-eu-central-1b"
          ][32m+][0m][0m "Project"                = "finpay"
          ][32m+][0m][0m "kubernetes.io/role/elb" = "1"
        }
      ][32m+][0m][0m vpc_id                                         = (known after apply)
    }

][1m  # module.vpc.aws_vpc.main][0m will be created
][0m  ][32m+][0m][0m resource "aws_vpc" "main" {
      ][32m+][0m][0m arn                                  = (known after apply)
      ][32m+][0m][0m cidr_block                           = "10.0.0.0/16"
      ][32m+][0m][0m default_network_acl_id               = (known after apply)
      ][32m+][0m][0m default_route_table_id               = (known after apply)
      ][32m+][0m][0m default_security_group_id            = (known after apply)
      ][32m+][0m][0m dhcp_options_id                      = (known after apply)
      ][32m+][0m][0m enable_dns_hostnames                 = true
      ][32m+][0m][0m enable_dns_support                   = true
      ][32m+][0m][0m enable_network_address_usage_metrics = (known after apply)
      ][32m+][0m][0m id                                   = (known after apply)
      ][32m+][0m][0m instance_tenancy                     = "default"
      ][32m+][0m][0m ipv6_association_id                  = (known after apply)
      ][32m+][0m][0m ipv6_cidr_block                      = (known after apply)
      ][32m+][0m][0m ipv6_cidr_block_network_border_group = (known after apply)
      ][32m+][0m][0m main_route_table_id                  = (known after apply)
      ][32m+][0m][0m owner_id                             = (known after apply)
      ][32m+][0m][0m tags                                 = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-vpc"
          ][32m+][0m][0m "Project"     = "finpay"
        }
      ][32m+][0m][0m tags_all                             = {
          ][32m+][0m][0m "Environment" = "production"
          ][32m+][0m][0m "ManagedBy"   = "Terraform"
          ][32m+][0m][0m "Name"        = "finpay-vpc"
          ][32m+][0m][0m "Project"     = "finpay"
        }
    }

][1mPlan:][0m ][0m96 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  ][32m+][0m][0m alb_controller_role_arn     = (known after apply)
  ][32m+][0m][0m app_config_secret_name      = "finpay/app/config"
  ][32m+][0m][0m cloudwatch_dashboard_name   = "finpay-dashboard"
  ][32m+][0m][0m cloudwatch_log_groups       = {
      ][32m+][0m][0m eks_cluster    = "/aws/eks/finpay-production-eks/cluster"
      ][32m+][0m][0m payment_api    = "/aws/eks/finpay-production-eks/payment-api"
      ][32m+][0m][0m payment_worker = "/aws/eks/finpay-production-eks/payment-worker"
    }
  ][32m+][0m][0m configure_kubectl           = "aws eks update-kubeconfig --region eu-central-1 --name finpay-production-eks"
  ][32m+][0m][0m database_name               = "paymentdb"
  ][32m+][0m][0m db_credentials_secret_name  = "finpay/database/credentials"
  ][32m+][0m][0m eks_cluster_endpoint        = (known after apply)
  ][32m+][0m][0m eks_cluster_name            = "finpay-production-eks"
  ][32m+][0m][0m eks_cluster_version         = "1.28"
  ][32m+][0m][0m eks_nodes_security_group_id = (known after apply)
  ][32m+][0m][0m eks_oidc_issuer_url         = (known after apply)
  ][32m+][0m][0m payment_api_role_arn        = (known after apply)
  ][32m+][0m][0m payment_worker_role_arn     = (known after apply)
  ][32m+][0m][0m private_subnet_ids          = [
      ][32m+][0m][0m (known after apply),
      ][32m+][0m][0m (known after apply),
    ]
  ][32m+][0m][0m public_subnet_ids           = [
      ][32m+][0m][0m (known after apply),
      ][32m+][0m][0m (known after apply),
    ]
  ][32m+][0m][0m rds_address                 = (known after apply)
  ][32m+][0m][0m rds_endpoint                = (known after apply)
  ][32m+][0m][0m rds_security_group_id       = (known after apply)
  ][32m+][0m][0m vpc_id                      = (known after apply)
][90m
─────────────────────────────────────────────────────────────────────────────][0m

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
