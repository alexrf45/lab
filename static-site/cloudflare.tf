
data "cloudflare_zones" "domain" {
  filter { name = var.site_domain }
}

locals {
  root_domain = join(".", reverse(slice(reverse(split(".", var.site_domain)), 0, 2)))
}


resource "cloudflare_record" "acm" {
  depends_on = [aws_acm_certificate.cert]

  zone_id         = data.cloudflare_zones.domain[0].id
  name            = replace(tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name, ".${local.root_domain}.", "")
  value           = trimsuffix(tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value, ".")
  type            = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  ttl             = 60
  proxied         = false
  allow_overwrite = false
}


resource "cloudflare_record" "cname" {
  depends_on      = [aws_cloudfront_distribution.dist]
  zone_id         = data.cloudflare_zones.domain[0].id
  name            = var.site_domain
  value           = aws_cloudfront_distribution.dist.domain_name
  type            = "CNAME"
  allow_overwrite = true
}


