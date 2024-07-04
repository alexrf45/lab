output "id" {
  description = "The ID of the instance"
  value       = module.example.id
}

output "vps_public_ip" {
  description = "public ip from Elastic IP allocation"
  value       = module.example.vps_public_ip
}

#uncomment if using TF generated ssh key
# output "ssh_key" {
#   description = "ssh private key for ssh access"
#   value       = tls_private_key.ssh_key.private_key_openssh
# }
