output "private-key" {
  value = tls_private_key.ssh_key.private_key_openssh
}

