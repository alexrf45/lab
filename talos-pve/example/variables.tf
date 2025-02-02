variable "password" {
  description = "pve node password"
  type        = string
  sensitive   = true
}
variable "cert-manager-manifest" {
  description = "url of cert-manager manifest"
  default     = "https://github.com/cert-manager/cert-manager/releases/download/v1.16.3/cert-manager.yaml"
}
