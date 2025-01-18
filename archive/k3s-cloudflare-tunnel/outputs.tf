output "secret" {
  value     = random_bytes.secret.base64
  sensitive = true
}

output "cname" {
  value = cloudflare_tunnel.dev.cname

}

output "tunnel_token" {
  value     = cloudflare_tunnel.dev.tunnel_token
  sensitive = true
}

output "service_record" {
  value = cloudflare_record.cname.hostname
}
