variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "project_name" {
  type    = string
  default = "finpay"
}

variable "github_org" {
  type = string
  default = "Qday12"
}

variable "github_repo" {
  type = string
  default = "k8s_payment_app"
}

variable "repositories" {
  type = map(any)
  default = {
    "payment-api"    = {}
    "payment-worker" = {}
  }
}
