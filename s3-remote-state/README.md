
# Terraform AWS S3 Remote State

## Module specifics

- Inputs for `env` are limited to: `dev` `testing` `stage` `prod`
- Inputs for `app` must be four letters or longer
- Bucket versioning can be enabled or disabled via the `versioning` input
- If and only if the environment is set to `dev`, the s3 bucket can be force destroyed
- **A `random_uuid` resource is used a suffix for the bucket name to allow for rapid creation and deletion.**

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

The following requirements are needed by this module:

- <a name="requirement_aws"></a> [aws](#requirement\_aws) (~> 5.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (3.6.3)

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (~> 5.0)

- <a name="provider_random"></a> [random](#provider\_random) (3.6.3)

## Resources

The following resources are used by this module:

- [aws_dynamodb_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) (resource)
- [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) (resource)
- [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) (resource)
- [aws_s3_bucket_public_access_block.public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) (resource)
- [aws_s3_bucket_server_side_encryption_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) (resource)
- [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) (resource)
- [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/uuid) (resource)
- [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) (data source)
- [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_env"></a> [env](#input\_env)

Description: code/app environement

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_app"></a> [app](#input\_app)

Description: app or project name

Type: `string`

Default: `"app"`

### <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags)

Description: Tags to set for all resources

Type: `map(any)`

Default:

```json
{
  "Name": "Remote State For Terraform",
  "environment": "dev",
  "project": "terraform-s3-remote-state"
}
```

### <a name="input_versioning"></a> [versioning](#input\_versioning)

Description: enable bucket versioning

Type: `string`

Default: `"Enabled"`

## Outputs

The following outputs are exported:

### <a name="output_account_id"></a> [account\_id](#output\_account\_id)

Description: n/a

### <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name)

Description: The name of the bucket

### <a name="output_caller_arn"></a> [caller\_arn](#output\_caller\_arn)

Description: n/a

### <a name="output_dynamodb_arn"></a> [dynamodb\_arn](#output\_dynamodb\_arn)

Description: ARN of dynamodb\_table

### <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name)

Description: The name of the DynamoDB table

### <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn)

Description: The ARN of the S3 bucket
<!-- END_TF_DOCS -->
