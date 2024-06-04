variable "site_domain" {
  type        = string
  description = "The domain name to use for the static site"
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(any)
  default = {
    project     = "Blog"
    environment = "dev"
    Name        = "Static Site"
  }
}
