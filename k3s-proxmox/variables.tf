
variable "storage_location" {
  description = "location of vm storage"
  type        = string
  default     = "local-lvm"
}

variable "backup" {
  description = "whether to include drive in backups"
  type        = bool
  default     = true
}

variable "replicate" {
  description = "whether to include drive in replication jobs"
  type        = bool
  default     = true
}


variable "nameserver" {
  description = "dns nameserver"
  type        = string
  default     = "10.3.3.1"
}

variable "ciuser" {
  description = "override default cloud-init user"
  type        = string
  default     = "ubuntu"
}

variable "cipassword" {
  description = "override cloud-init password"
  type        = string
  default     = "password1234"
}


