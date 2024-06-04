resource "aws_acm_certificate" "cert" {
  domain_name       = var.site_domain
  validation_method = "DNS"
  tags              = var.resource_tags


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "validate" {
  depends_on              = [cloudflare_record.acm]
  certificate_arn         = module.certs.arn
  validation_record_fqdns = [tolist(module.certs.validation)[0].resource_record_name]
  timeouts {
    create = "8m"

  }
}
