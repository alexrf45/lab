
variable "env" {
  description = "code/app environement"
  type        = string
  validation {
    condition = anytrue([
      var.env == "dev",
      var.env == "stage",
      var.env == "prod",
      var.env == "testing"
    ])
    error_message = "Please use one of the approved environement names: dev, stage, prod, testing"
  }
}

variable "app" {
  description = "app or project name"
  type        = string
  default     = ""
  validation {
    condition     = length(var.app) > 4
    error_message = "app name must be at least 4 characters"
  }
}

variable "aws_region" {
  type = string
}
variable "aws_region_2" {
  type = string
}
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
