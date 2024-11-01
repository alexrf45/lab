variable "cf_account_id" {
  description = "cloudflare account ID"
  type        = string
  sensitive   = true
}

variable "cf_api_token" {
  description = "cloudflare api token"
  type        = string
  sensitive   = true
}
