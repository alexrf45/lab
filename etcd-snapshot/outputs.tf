output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.etcd.arn
  description = "The ARN of the S3 bucket"
}

output "bucket_name" {
  value       = aws_s3_bucket.etcd.id
  description = "The name of the bucket"
}

output "secret_key" {
  description = "access secret key"
  value       = aws_iam_access_key.etcd_key.secret
  sensitive   = true

}

output "access_key_id" {
  description = "iam user id"
  value       = aws_iam_access_key.etcd_key.id

}
