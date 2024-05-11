
# Terraform Remote state using s3

## Module specifics

- Inputs for `env` are limited to: `dev` `testing` `stage` `prod`
- Inputs for `app` must be four letters or longer
- Bucket versioning can be enabled or disabled via the `versioning` input
- If and only if the environment is set to `dev`, the s3 bucket can be force destroyed

1. Set up folder and deploy resources with a local tfstate file

2. Once resources are deployed, uncomment the backend and migrate the state to the newly created bucket

3. Deploy a vps using the s3 backend

**Remember in a production environment to store the state of the state storage somewhere else**



# Simple dev remote state module for deploying a vps

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

module "vps" {
  source     = "github.com/alexrf45/tf-modules-resume.git//aws/s3-remote-state?ref=V3.0.2"
  env        = "dev"
  app        = "bug-bounty"
  versioning = "Disabled"
}
```

# Module outputs.tf:

```
output "caller_arn" {
  value = module.vps.caller_arn
}

output "account_id" {
  value = module.vps.account_id
}

output "s3_bucket_arn" {
  value       = module.vps.s3_bucket_arn
  description = "The ARN of the S3 bucket"
}

output "bucket_name" {
  value       = module.vps.bucket_name
  description = "The name of the bucket"
}

output "dynamodb_table_name" {
  value = module.vps.dynamodb_table_name
}

output "dynamodb_arn" {
  value       = module.vps.dynamodb_arn
  description = "ARN of dynamodb_table"
}

```

# Resources

COMING SOON

| Name | Type |
|---|---|
|   |   |
|   |   |
|   |   |


# Outputs

COMING SOON
