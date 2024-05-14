variable "etcd_count" {
  description = "number of etcd hosts"
  type        = number
  default     = 0
}

variable "etcd_size" {
  description = "vm size for etcd"
  type        = number
  default     = 30

}

variable "etcd_memory" {
  description = "vm memory"
  type        = number
  default     = 2048
}
variable "control_plane_count" {
  description = "number of control plane hosts"
  type        = number
  default     = 0
}

variable "control_plane_size" {
  description = "vm size for etcd"
  type        = number
  default     = 30

}
variable "control_plane_memory" {
  description = "vm memory"
  type        = number
  default     = 2048
}
variable "node_count" {
  description = "number of node hosts"
  type        = number
  default     = 0
}

variable "node_size" {
  description = "vm size for etcd"
  type        = number
  default     = 30

}
variable "node_memory" {
  description = "vm memory"
  type        = number
  default     = 2048
}
variable "description" {
  description = "description of resource"
  type        = string
  default     = "resource"
}

variable "cores" {
  description = "number of virtual cores"
  type        = number
  default     = 1
}
variable "os_type" {
  description = "operating system type"
  type        = string
  default     = "cloud-init"
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

variable "boot" {
  description = "boot order"
  type        = string
  default     = "order=scsi0;ide3"
}


