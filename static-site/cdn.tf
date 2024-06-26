module "certs" {
  providers = {
    aws = aws.east
  }
  source        = "./certs/"
  site_domain   = var.site_domain
  resource_tags = var.resource_tags
}

resource "aws_acm_certificate_validation" "validate" {
  provider                = aws.east
  depends_on              = [cloudflare_record.acm]
  certificate_arn         = module.certs.arn
  validation_record_fqdns = [tolist(module.certs.validation)[0].resource_record_name]
  timeouts {
    create = "8m"

  }
}

resource "aws_cloudfront_origin_access_identity" "site" {
  comment = "access-identity-${aws_s3_bucket.site.bucket_domain_name}"
}


resource "aws_cloudfront_distribution" "dist" {
  depends_on = [aws_s3_bucket.site, aws_acm_certificate_validation.validate]
  comment    = "static site"

  origin {
    domain_name = aws_s3_bucket_website_configuration.site.website_endpoint
    origin_id   = "S3-${aws_s3_bucket.site.id}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [var.site_domain]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.site.id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn            = module.certs.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 400
    response_code         = 404
    response_page_path    = "/404.html"
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 403
    response_code         = 404
    response_page_path    = "/404.html"
  }
  tags = var.resource_tags
}
