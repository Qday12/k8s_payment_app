terraform {
  # Remote backend configuration
  backend "s3" {
    bucket         = "finpay-terraform-state"
    key            = "production/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "finpay-terraform-locks"
  }
}