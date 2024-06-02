variable "hcloud_token" {
  sensitive = true
  type      = string
}

variable "username" {
  description = "ssh user"
  type        = string
  default     = "dev"
}

variable "api_token" {
  description = "cloudflare token"
  type        = string
}

variable "zone_id" {
  description = "cloudflare zone id"
  type        = string
}

variable "ssh_key_path" {
  description = "path of local ssh public key to associate with vps"
  type        = string
  default     = "~/.ssh/vps.pub"

}

variable "image" {
  description = "iso image for vps"
  type        = string
  default     = "debian-12"
}

variable "server_name" {
  description = "name of server"
  type        = string
  default     = "vps-server"
}

variable "server_type" {
  description = "instance type"
  type        = string
  default     = "cpx11"
}

variable "location" {
  description = "datacenter location"
  type        = string
  default     = "ash-dc1"
}

variable "dns_ptr" {
  description = "A record to associate with primary IP"
  type        = string
}



