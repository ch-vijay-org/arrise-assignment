terraform {
  backend "s3" {
    bucket         = "company-terraform-state-prod"
    key            = "ec2/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
