output "secret" {
  value     = random_bytes.secret.base64
  sensitive = true
}

output "name" {
  value = cloudflare_zero_trust_tunnel_cloudflared.this.name

}
