output "id" {
  description = "id of cloud-init config"
  value       = data.cloudinit_config.test.id
}

output "rendered" {
  description = "the final rendered multi-part cloud init config"
  value       = data.cloudinit_config.test.rendered
}

output "base64_rendered" {
  description = "base64 encoded cloud init config"
  value       = data.cloudinit_config.test.base64_encode
}
