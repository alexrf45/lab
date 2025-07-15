<!-- BEGIN_TF_DOCS -->


# k8s-s3-storage: multi-function bucket for object storage

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.37.1 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.7.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | app or project name | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | code/app environement | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | IAM Username | `string` | n/a | yes |
| <a name="input_create_k8s_secret"></a> [create\_k8s\_secret](#input\_create\_k8s\_secret) | whether to enable the creation and injection of a k8s secret | `bool` | `false` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | owner of app. Can be the application owner or user | `string` | `"admin"` | no |
| <a name="input_path"></a> [path](#input\_path) | path of IAM user | `string` | `"/app/"` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | enable bucket versioning | `string` | `"Disabled"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_id"></a> [access\_id](#output\_access\_id) | Access Key ID |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the bucket |
| <a name="output_bucket_url"></a> [bucket\_url](#output\_bucket\_url) | Bucket Url |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | IAM Role ARN |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the S3 bucket |
| <a name="output_secret"></a> [secret](#output\_secret) | Access Secret Key |
| <a name="output_user_arn"></a> [user\_arn](#output\_user\_arn) | IAM User ARN |
<!-- END_TF_DOCS -->