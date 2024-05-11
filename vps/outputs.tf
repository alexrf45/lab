output "id" {
  description = "The ID of the instance"
  value       = aws_instance.jump_instance.id
}

output "vps_public_ip" {
  description = "public ip from Elastic IP allocation"
  value       = aws_eip.jump_eip.public_ip
}

