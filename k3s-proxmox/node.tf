resource "proxmox_vm_qemu" "cloudinit-k3s-node" {
  count       = var.node_count
  vmid        = "300${count.index + 1}"
  target_node = var.node_nodes[count.index]
  tags        = "control_plane"
  desc        = "k3s node"
  onboot      = true
  clone       = var.node_template[count.index]
  agent       = 0
  os_type     = "cloud-init"
  cores       = 2
  sockets     = 2
  numa        = true
  vcpus       = 2
  cpu         = "host"
  memory      = var.node_memory
  name        = "k3s-node-0${count.index + 1}"

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  boot     = "order=scsi0;ide3"

  disks {
    ide {
      ide3 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage   = var.storage_location
          size      = var.node_size
          backup    = true
          replicate = var.replicate
        }
      }
    }
  }

  ipconfig0  = "ip=${var.node_cidr}${count.index + 1}/24,gw=${var.nameserver}"
  ciuser     = var.ciuser
  nameserver = var.nameserver
  sshkeys    = file("~/.ssh/lab.pub")

}

####### VARIABLES ########



variable "node_count" {
  description = "number of node vms to deploy"
  type        = number
  default     = 1
}
variable "node_template" {
  description = "template for nodes"
  type        = list(string)
}

variable "node_nodes" {
  description = "node to deploy vm on"
  type        = list(string)
}
variable "node_memory" {
  description = "memory for nodes"
  type        = number
  default     = 2048
}

variable "node_size" {
  description = "vm size for control plane and nodes"
  type        = number
  default     = 30
}

variable "node_cidr" {
  description = "cidr for vm IP addresses"
  type        = string
  default     = "10.3.3.10"
}


