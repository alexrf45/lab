output "private-key" {
  value     = tls_private_key.ssh_ed25519.private_key_openssh
  sensitive = true
}

