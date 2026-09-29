variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
 
variable "account_a_profile" {
  description = "AWS CLI profile for Account A"
  type        = string
}
 
variable "account_b_profile" {
  description = "AWS CLI profile for Account B"
  type        = string
}
 
variable "s3_bucket_name" {
  description = "S3 bucket in Account B"
  type        = string
}
 
variable "group2_users" {
  description = "Two named users requiring console and CLI access"
  type        = list(string)
 
  default = [
    "developer1",
    "developer2"
  ]
}
 
variable "group2_password" {
  description = "Temporary console password for lab users"
  type        = string
  sensitive   = true
}
