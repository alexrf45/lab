output "id" {
  description = "The ID of the instance"
  value       = aws_instance.vps_instance.id
}

output "vps_public_ip" {
  description = "public ip from Elastic IP allocation"
  value       = aws_eip.eip.public_ip
}

output "private-key" {
  description = "private key for logging in via ssh"
  value       = tls_private_key.ssh-ed25519.private_key_openssh
  sensitive   = true
}
