resource "proxmox_vm_qemu" "cloudinit-k3s-ext-etcd" {
  vmid        = var.etcd_id
  tags        = "etcd"
  target_node = var.etcd_node
  desc        = "etcd"
  onboot      = true
  clone       = var.etcd_template
  agent       = 0

  os_type = "cloud-init"
  cores   = 2
  sockets = 2
  numa    = true
  vcpus   = 2
  cpu     = "host"
  memory  = var.etcd_memory
  name    = "k3s-etcd"

  scsihw   = "virtio-scsi-single"
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
          size      = var.db_size
          backup    = var.backup
          replicate = var.replicate
        }
      }
    }
  }
  ipconfig0  = var.etcd_ip
  ciuser     = "dbadmin"
  cipassword = var.dbpass
  nameserver = var.nameserver
  sshkeys    = file("~/.ssh/lab.pub")
}

################# VARIABLES############################
variable "etcd_node" {
  description = "pve node"
  type        = string
  default     = "home-1"
}

variable "etcd_id" {
  description = "etcd vm id"
  type        = string
  default     = "1001"
}

variable "etcd_template" {
  description = "template to use for vm"
  type        = string
}

variable "etcd_memory" {
  description = "memory alloted for etcd vm"
  type        = number
  default     = 8092
}

variable "db_size" {
  description = "vm size for etcd"
  type        = number
  default     = 50

}

variable "etcd_ip" {
  description = "cidr for vm IP addresses"
  type        = string
  default     = ""
}

variable "dbpass" {
  description = "password for db"
  type        = string
  default     = "password123"
  sensitive   = true
}




