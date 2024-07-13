
data "cloudflare_zones" "domain" {
  filter { name = var.site_domain }
}


resource "random_bytes" "secret" {
  length = 64
}


resource "cloudflare_tunnel" "dev" {
  account_id = var.account_id
  name       = "${var.env}-${var.app}"
  secret     = random_bytes.secret.base64
}


resource "cloudflare_tunnel_config" "tunnel" {
  account_id = var.account_id
  tunnel_id  = cloudflare_tunnel.dev.id

  config {
    origin_request {

      no_tls_verify = true
    }
    ingress_rule {
      hostname = "${var.env}-${var.app}.${var.site_domain}"
      #path     = "*"
      service = var.service_domain
    }
    ingress_rule {
      service = "http_status:404"
    }
  }

}

resource "cloudflare_record" "cname" {
  zone_id         = data.cloudflare_zones.domain.zones[0].id
  name            = cloudflare_tunnel.dev.name
  value           = cloudflare_tunnel.dev.cname
  type            = "CNAME"
  allow_overwrite = true
  proxied         = var.proxied
  ttl             = 1
}


