
variable "tags" {
  description = "tags for vm"
  type        = string
  default     = "virtual machine"
}

variable "template" {
  description = "name of cloud init template to use"
  type        = list(string)
}


variable "size" {
  description = "vm size for etcd"
  type        = number
  default     = 30

}

variable "memory" {
  description = "VM memory"
  type        = number
  default     = 2048
}
variable "vm_count" {
  description = "number of VMs to deploy"
  type        = number
  default     = 1
}

variable "vm_name" {
  description = "naming convention of VMs"
  type        = list(string)
}

variable "nodes" {
  description = "pve nodes that vm will be deployed to"
  type        = list(string)
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

variable "cidr" {
  description = "CIDR for assigning cloud init IP addresses to the vms"
  type        = string
  default     = "10.3.3.3"
}

variable "nameserver" {
  description = "dns nameserver"
  type        = string
  default     = ""
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


