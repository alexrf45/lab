
Format of aws_acm_certificate_validation.domain_validation_options

Ref: https://github.com/hashicorp/terraform/issues/26043#issuecomment-683119243

After the upgrade to terraform 0.13 you can't use the domain_validation_options[0] or domain_validation_options.0.

To make the reference work, use tolist(aws_acm_certificate.example.domain_validation_options)[0])



CustomConfig for Cloudfront Origin 

Ref: https://github.com/aws/aws-sdk-js/issues/2368

Static websites won't work correctly with regular s3 endpoint, you have to specify the website endpoint but
terraform doesn't allow that in the origin config portion of the aws_cloudfront_distribution block. You have to specify
custom_origin_config (It's basically what you would do in the console but obviously no toil is the goal.)
