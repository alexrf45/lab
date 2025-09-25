variable "vm_config" {
  description = "vm variables"
  type        = map(any)
}


variable "onboot" {
  description = "whether to have the vm power on after creation"
  type        = bool
  default     = true
}

variable "agent" {
  description = "enable qemu agent"
  type        = number
  default     = 0
}

variable "bios" {
  description = "enable bios or efi"
  type        = string
  default     = "seabios"
}
variable "description" {
  description = "description of resource"
  type        = string
  default     = "resource"
}

variable "numa" {
  description = "not sure what it does"
  type        = bool
  default     = true
}

variable "vcpu" {
  description = "number of virtual cpus"
  type        = number
  default     = 1
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


variable "ssh_key_path" {
  description = "file path of ssh public key"
  type        = string
  default     = "$HOME/.ssh/lab.pub"
}
variable "boot" {
  description = "boot order"
  type        = string
  default     = "order=scsi0;ide3"
}


