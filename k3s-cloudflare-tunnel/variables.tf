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
}
variable "subdomain" {
  description = "subdomain for tunnel to resolve to"
  type        = string
  default     = ""
}


variable "site_domain" {
  description = "domain name of specified zone"
  type        = string
}

variable "api_token" {
  description = "cloudflare api token"
  type        = string
}
variable "account_id" {
  type = string
}

variable "proxied" {
  description = "whether to proxy dns through cloudflare"
  type        = bool
  default     = true
}

variable "service_domain" {
  type        = string
  description = "domain of k3s service i.e http://web-service:80"
}

variable "k3s_config_file_path" {
  description = "file path for kube config"
  type        = string
  default     = "~/.kube/config"
}

variable "namespace" {
  description = "namespace to deploy tunnel in"
  type        = string
  default     = "default"
}

variable "replicas" {
  description = "number of replicas for cloudflare deployment"
  type        = number
  default     = 2
}
