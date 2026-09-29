output "engine_access_key_id" {
  value = aws_iam_access_key.engine.id
}
 
output "ci_access_key_id" {
  value = aws_iam_access_key.ci.id
}
 
output "role_a_arn" {
  value = aws_iam_role.role_a.arn
}
 
output "role_b_arn" {
  value = aws_iam_role.role_b.arn
}
 
output "role_c_arn" {
  value = aws_iam_role.role_c.arn
}
 
output "s3_bucket_arn" {
  value = aws_s3_bucket.target.arn
}
