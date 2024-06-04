resource "aws_acm_certificate" "cert" {
  domain_name       = var.site_domain
  validation_method = "DNS"
  tags              = var.resource_tags


  lifecycle {
    create_before_destroy = true
  }
}
