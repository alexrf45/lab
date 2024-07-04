output "id" {
  description = "The ID of the instance"
  value       = aws_instance.instance.id
}

output "vps_public_ip" {
  description = "public ip from Elastic IP allocation"
  value       = aws_eip.eip.public_ip
}

output "ssh_key" {
  description = "ssh private key for ssh access"
  value       = tls_private_key.ssh_key.private_key_openssh
}

