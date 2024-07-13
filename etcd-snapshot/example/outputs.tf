output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "s3_bucket_arn" {
  value       = module.etcd_snapshot.s3_bucket_arn
  description = "The ARN of the S3 bucket"
}

output "bucket_name" {
  value       = module.etcd_snapshot.bucket_name
  description = "The name of the bucket"
}

output "secret_key" {
  description = "access secret key"
  value       = module.etcd_snapshot.secret_key
  sensitive   = true

}

output "access_key_id" {
  description = "iam user id"
  value       = module.etcd_snapshot.access_key_id

}
