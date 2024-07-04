
# Static Website Using AWS, Cloudflare, Github Actions, Hugo & Terraform


## Troubleshooting

Format of aws_acm_certificate_validation.domain_validation_options

Ref: https://github.com/hashicorp/terraform/issues/26043#issuecomment-683119243

After the upgrade to terraform 0.13 you can't use the domain_validation_options[0] or domain_validation_options.0.

To make the reference work, use tolist(aws_acm_certificate.example.domain_validation_options)[0])



## CustomConfig for Cloudfront Origin

Ref: https://github.com/aws/aws-sdk-js/issues/2368

Static websites won't work correctly with regular s3 endpoint, you have to specify the website endpoint but
terraform doesn't allow that in the origin config portion of the aws_cloudfront_distribution block. You have to specify
custom_origin_config (It's basically what you would do in the console but obviously no toil is the goal.)

# Example using github actions, oidc provider and iam role to deploy site
```
provider "aws" {
  region = var.aws_region
}


provider "cloudflare" {
  api_token   = var.cloudflare_api_token
  retries     = 2
  min_backoff = 15
}


module "site" {
  source        = "github.com/alexrf45/lab.git//static-site?ref=v0.0.2"
  site_domain   = var.site_domain
  resource_tags = var.resource_tags
}


resource "aws_iam_openid_connect_provider" "this" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["ffffffffffffffffffffffffffffffffffffffff"]
}

data "aws_iam_policy_document" "oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.this.arn]
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    condition {
      test     = "StringLike"
      values   = ["repo:alexrf45/fr3d.dev:*"]
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "github_oidc_role"
  assume_role_policy = data.aws_iam_policy_document.oidc.json
}

data "aws_iam_policy_document" "deploy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
      "cloudfront:*",
      "acm:*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "deploy" {
  name        = "ci-deploy-policy"
  description = "Policy used for deployments on CI"
  policy      = data.aws_iam_policy_document.deploy.json
}

resource "aws_iam_role_policy_attachment" "attach-deploy" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.deploy.arn
}

```



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.46.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 4.30.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.46.0 |
| <a name="provider_aws.east"></a> [aws.east](#provider\_aws.east) | 5.46.0 |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 4.30.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_certs"></a> [certs](#module\_certs) | ./certs/ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate_validation.validate](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/acm_certificate_validation) | resource |
| [aws_cloudfront_distribution.dist](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.site](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_s3_bucket.site](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.site](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.public_access](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_website_configuration.site](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/s3_bucket_website_configuration) | resource |
| [cloudflare_record.acm](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.cname](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [random_uuid.test](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [cloudflare_zones.domain](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | n/a | yes |
| <a name="input_aws_region_2"></a> [aws\_region\_2](#input\_aws\_region\_2) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | code/app environement | `string` | n/a | yes |
| <a name="input_site_domain"></a> [site\_domain](#input\_site\_domain) | The domain name to use for the static site | `string` | n/a | yes |
| <a name="input_app"></a> [app](#input\_app) | app or project name | `string` | `""` | no |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Tags to set for all resources | `map(any)` | <pre>{<br>  "Name": "Static Site",<br>  "environment": "dev",<br>  "project": "Blog"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Website endpoint |
| <a name="output_validation"></a> [validation](#output\_validation) | A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used. |
| <a name="output_website_bucket_name"></a> [website\_bucket\_name](#output\_website\_bucket\_name) | Name (id) of the bucket |
<!-- END_TF_DOCS -->
