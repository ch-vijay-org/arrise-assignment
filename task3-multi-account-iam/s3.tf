resource "aws_s3_bucket" "target" {
  provider = aws.account_b
 
  bucket = var.s3_bucket_name
}
##Enable Versioning
resource "aws_s3_bucket_versioning" "target" {
  provider = aws.account_b
 
  bucket = aws_s3_bucket.target.id
 
  versioning_configuration {
    status = "Enabled"
  }
}
## Enable Versioning
resource "aws_s3_bucket_server_side_encryption_configuration" "target" {
  provider = aws.account_b
 
  bucket = aws_s3_bucket.target.id
 
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
## Block Public Access
resource "aws_s3_bucket_public_access_block" "target" {
  provider = aws.account_b
 
  bucket = aws_s3_bucket.target.id
 
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
