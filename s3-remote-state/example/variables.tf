variable "region" {
  description = "aws region to deploy resources in"
  type        = string
  default     = "us-east-1"
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
