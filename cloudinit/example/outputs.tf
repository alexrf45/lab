output "id" {
  description = "id of cloud-init config"
  value       = module.example.id
}

output "rendered" {
  description = "the final rendered multi-part cloud init config"
  value       = module.example.rendered
}

output "base64_rendered" {
  description = "base64 encoded cloud init config"
  value       = module.example.base64_rendered
}
