terraform {
  required_version = ">= 1.5.0"
 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
 
# Account A
provider "aws" {
  alias  = "account_a"
  region = var.aws_region
 
  profile = var.account_a_profile
}
 
# Account B
provider "aws" {
  alias  = "account_b"
  region = var.aws_region
 
  profile = var.account_b_profile
}
