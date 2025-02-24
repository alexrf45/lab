variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(any)
  default = {
    project     = "terraform-s3-remote-state"
    environment = "dev"
    Name        = "Remote State For Terraform"
  }
}


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
  default     = "app"
}

variable "versioning" {
  description = "enable bucket versioning"
  type        = string
  default     = "Enabled"
  validation {
    condition = anytrue([
      var.versioning == "Enabled",
      var.versioning == "Disabled"
    ])
    error_message = "Please specify Enabled or Disabled"
  }
}
