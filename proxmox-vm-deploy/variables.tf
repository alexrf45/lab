variable "vm_configs" {
  description = "vm variables"
  type        = map(any)

}


variable "description" {
  description = "description of resource"
  type        = string
  default     = "resource"
}


variable "cores" {
  description = "number of cores"
  type        = number
  default     = 1
}

variable "sockets" {
  description = "number of sockets"
  type        = number
  default     = 1
}


variable "cpu_type" {
  description = "type of cpu"
  type        = string
  default     = "host"
}


variable "scsihw" {
  description = "type of virtual drive in use"
  type        = string
  default     = "virtio-scsi-pci"
}

variable "boot_disk" {
  description = "boot disk name/ID"
  type        = string
  default     = "scsi0"
}

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

variable "boot" {
  description = "boot order"
  type        = string
  default     = "order=scsi0;ide3"
}


