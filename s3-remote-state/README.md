
# Terraform AWS S3 Remote State

## Module specifics

- Inputs for `env` are limited to: `dev` `testing` `stage` `prod`
- Inputs for `app` must be four letters or longer
- Bucket versioning can be enabled or disabled via the `versioning` input
- If and only if the environment is set to `dev`, the s3 bucket can be force destroyed

1. Set up folder and deploy resources with a local tfstate file

2. Once resources are deployed, uncomment the backend and migrate the state to the newly created bucket

3. Deploy a terraform remote-state using the s3 backend

**Remember in a production environment to backup the remote state storage in case of state corruption**



# Simple dev remote state module for deploying a remote-state

```
provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket         = "BUCKET_NAME from output"
    region         = "REGION"
    dynamodb_table = "TABLE_NAME from output"
    encrypt        = true
    key            = "state/dev/terraform.tfstate" #key structure should follow environment & app naming convention
  }
}

module "remote-state" {
  source     = "github.com/alexrf45/lab.git//s3-remote-state"
  env        = "dev"
  app        = "demo"
  versioning = "Disabled"
}
```

# Module outputs.tf:

```
output "caller_arn" {
  value = module.remote-state.caller_arn
}

output "account_id" {
  value = module.remote-state.account_id
}

output "s3_bucket_arn" {
  value       = module.remote-state.s3_bucket_arn
  description = "The ARN of the S3 bucket"
}

output "bucket_name" {
  value       = module.remote-state.bucket_name
  description = "The name of the bucket"
}

output "dynamodb_table_name" {
  value = module.remote-state.dynamodb_table_name
}

output "dynamodb_arn" {
  value       = module.remote-state.dynamodb_arn
  description = "ARN of dynamodb_table"
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform_locks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_s3_bucket.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.enabled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.s3-backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | app or project name | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | code/app environement | `string` | n/a | yes |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | enable bucket versioning | `string` | `"Enabled"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | n/a |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the bucket |
| <a name="output_caller_arn"></a> [caller\_arn](#output\_caller\_arn) | n/a |
| <a name="output_dynamodb_arn"></a> [dynamodb\_arn](#output\_dynamodb\_arn) | ARN of dynamodb\_table |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | The name of the DynamoDB table |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the S3 bucket |
<!-- END_TF_DOCS -->
