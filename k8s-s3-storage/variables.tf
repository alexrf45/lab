variable "create_k8s_secret" {
  description = "whether to enable the creation and injection of a k8s secret"
  type        = bool
  default     = false
}

variable "owner" {
  description = "owner of app. Can be the application owner or user"
  type        = string
  default     = "admin"
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
  validation {
    condition     = length(var.app) > 4
    error_message = "app name must be at least 4 characters"
  }
}

variable "versioning" {
  description = "enable bucket versioning"
  type        = string
  default     = "Disabled"
  validation {
    condition = anytrue([
      var.versioning == "Enabled",
      var.versioning == "Disabled"
    ])
    error_message = "Please specify Enabled or Disabled"
  }
}


variable "path" {
  description = "path of IAM user"
  type        = string
  default     = "/app/"
}

variable "username" {
  description = "IAM Username"
  type        = string
}
