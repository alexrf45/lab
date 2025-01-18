output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "The ARN of the S3 bucket"
}

output "bucket_name" {
  value       = aws_s3_bucket.this.id
  description = "The name of the bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.this.name
  description = "The name of the DynamoDB table"
}

output "dynamodb_arn" {
  value       = aws_dynamodb_table.this.arn
  description = "ARN of dynamodb_table"
}
