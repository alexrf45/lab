resource "proxmox_vm_qemu" "cloudinit-k3s-control-plane" {
  count       = var.control_plane_count
  vmid        = var.control_plane_id[count.index]
  target_node = var.control_plane_node[count.index]
  desc        = "control_plane"
  tags        = "control_plane"
  onboot      = true
  clone       = var.control_plane_template[count.index]
  agent       = 0
  os_type     = "cloud-init"
  cores       = 2
  sockets     = 2
  numa        = true
  vcpus       = 2
  cpu         = "host"
  memory      = var.control_plane_memory
  name        = "k3s-control-plane-0${count.index + 1}"

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  boot     = "order=scsi0;ide3"

  disks {
    ide {
      ide3 {
        cloudinit {
          storage = var.storage_location
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage   = var.storage_location
          size      = var.control_plane_size
          backup    = var.backup
          replicate = var.replicate
        }
      }
    }
  }
  ipconfig0  = "ip=${var.control_plane_cidr}${count.index + 1}/24,gw=${var.nameserver}"
  ciuser     = var.ciuser
  cipassword = var.cipassword
  nameserver = var.nameserver
  sshkeys    = file("~/.ssh/lab.pub")
}

###### VARIABLES ############

variable "control_plane_count" {
  description = "number of VMs to deploy"
  type        = number
  default     = 1
}

variable "control_plane_id" {
  description = "vm id"
  type        = list(string)
}

variable "control_plane_node" {
  description = "pve node"
  type        = list(string)
}

variable "control_plane_template" {
  description = "vm template for control plane"
  type        = list(string)
}

variable "control_plane_memory" {
  description = "memory alloted for vm"
  type        = number
  default     = 2048
}

variable "control_plane_size" {
  description = "vm size for control plane and nodes"
  type        = number
  default     = 30
}

variable "control_plane_cidr" {
  description = "cidr for vm IP addresses"
  type        = string
  default     = "10.3.3.10"
}
