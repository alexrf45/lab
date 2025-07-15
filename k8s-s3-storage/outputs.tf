output "s3_bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "The ARN of the S3 bucket"
}

output "bucket_name" {
  value       = aws_s3_bucket.this.id
  description = "The name of the bucket"
}

output "bucket_url" {
  value       = aws_s3_bucket.this.bucket_domain_name
  description = "Bucket Url"
}

output "user_arn" {
  value       = aws_iam_user.this.arn
  description = "IAM User ARN"
}

output "iam_role_arn" {
  value       = aws_iam_role.this.arn
  description = "IAM Role ARN"
  sensitive   = true
}

output "access_id" {
  value       = aws_iam_access_key.this.id
  sensitive   = true
  description = "Access Key ID"
}

output "secret" {
  value       = aws_iam_access_key.this.secret
  sensitive   = true
  description = "Access Secret Key"
}
