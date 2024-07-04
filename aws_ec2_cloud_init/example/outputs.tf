output "id" {
  description = "The ID of the instance"
  value       = module.vps.id
}

output "vps_public_ip" {
  description = "public ip from Elastic IP allocation"
  value       = module.vps.vps_public_ip
}

output "ssh_key" {
  description = "ssh private key"
  value       = module.vps.ssh_key
  sensitive   = true
}
