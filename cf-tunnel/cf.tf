resource "random_bytes" "secret" {
  length = 64
}


resource "cloudflare_zero_trust_tunnel_cloudflared" "this" {
  account_id    = var.account_id
  name          = var.tunnel_name
  config_src    = "cloudflare"
  tunnel_secret = random_bytes.secret.base64
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "this" {
  account_id = var.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id

  config = {
    ingress = concat(
      [
        {
          hostname = "${var.primary_subdomain}.${var.domain}"
          service  = var.primary_service_url
        }
      ],
      [
        for service in var.home_services : {
          hostname = "${service.subdomain}.${var.domain}"
          service  = service.service_url
        }
      ],
      [
        {
          service = "http_status:404"
        }
      ]
    )
  }
}

resource "cloudflare_dns_record" "primary" {
  zone_id = var.zone_id
  name    = var.primary_subdomain
  ttl     = 1
  content = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_dns_record" "services" {
  for_each = { for service in var.home_services : service.subdomain => service }

  zone_id = var.zone_id
  ttl     = 1
  name    = each.value.subdomain
  content = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"

  type    = "CNAME"
  proxied = true
}



