
Format of aws_acm_certificate_validation.domain_validation_options

Ref: https://github.com/hashicorp/terraform/issues/26043#issuecomment-683119243

After the upgrade to terraform 0.13 you can't use the domain_validation_options[0] or domain_validation_options.0.

To make the reference work, use tolist(aws_acm_certificate.example.domain_validation_options)[0])



CustomConfig for Cloudfront Origin 

Ref: https://github.com/aws/aws-sdk-js/issues/2368

Static websites won't work correctly with regular s3 endpoint, you have to specify the website endpoint but
terraform doesn't allow that in the origin config portion of the aws_cloudfront_distribution block. You have to specify
custom_origin_config (It's basically what you would do in the console but obviously no toil is the goal.)

## Example using github actions, oidc provider and iam role to deploy site
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
