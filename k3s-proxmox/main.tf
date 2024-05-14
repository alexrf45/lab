
resource "tls_private_key" "ssh_ed25519" {
  algorithm = "ED25519"
}

### etcd
resource "proxmox_vm_qemu" "etcd_vm" {
  timeouts {
    create = "6m"
  }
  count       = var.etcd_count
  tags        = "etcd"
  vmid        = "200${count.index}"
  name        = "etcd-vm-${count.index + 1}"
  target_node = "home-${count.index + 1}"
  desc        = var.description
  onboot      = true
  clone       = "h${count.index + 1}-vm"
  numa        = true
  os_type     = var.os_type
  cores       = var.cores
  vcpus       = 1
  memory      = var.etcd_memory

  #cloudinit_cdrom_storage = "nvme"
  scsihw   = var.scsihw
  bootdisk = var.boot_disk

  disks {
    scsi {
      scsi0 {
        disk {
          storage   = var.storage_location
          size      = var.etcd_size
          backup    = var.backup
          replicate = var.replicate
        }
      }
    }
  }
  ipconfig0               = "ip=10.3.3.3${count.index + 1}/24,gw=${var.nameserver}"
  ciuser                  = var.ciuser
  cipassword              = var.cipassword
  cloudinit_cdrom_storage = var.storage_location
  boot                    = var.boot
  nameserver              = var.nameserver
  sshkeys                 = tls_private_key.ssh_ed25519.public_key_openssh
}

## control-plane
resource "proxmox_vm_qemu" "control_plane_vm" {
  timeouts {
    create = "6m"
  }
  count       = var.control_plane_count
  tags        = "control-plane"
  vmid        = "300${count.index}"
  name        = "control-plane-vm-${count.index + 1}"
  target_node = "home-${count.index + 1}"
  desc        = var.description
  onboot      = true
  clone       = "h${count.index + 1}-vm"
  numa        = true
  cores       = var.cores
  os_type     = var.os_type
  vcpus       = 1
  memory      = var.control_plane_memory

  #cloudinit_cdrom_storage = "nvme"
  scsihw   = var.scsihw
  bootdisk = var.boot_disk

  disks {
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
  ipconfig0               = "ip=10.3.3.4${count.index + 1}/24,gw=${var.nameserver}"
  ciuser                  = var.ciuser
  cipassword              = var.cipassword
  cloudinit_cdrom_storage = var.storage_location
  boot                    = var.boot
  nameserver              = var.nameserver
  sshkeys                 = tls_private_key.ssh_ed25519.public_key_openssh
}


### nodes
resource "proxmox_vm_qemu" "node_vm" {
  timeouts {
    create = "6m"
  }
  count       = var.node_count
  tags        = "node"
  vmid        = "600${count.index}"
  name        = "node-vm-${count.index + 1}"
  target_node = "home-${count.index + 1}"
  desc        = var.description
  onboot      = true
  clone       = "h${count.index + 1}-vm"
  numa        = true
  os_type     = var.os_type
  cores       = var.cores
  vcpus       = 1
  memory      = var.node_memory
  #cloudinit_cdrom_storage = "nvme"
  scsihw   = var.scsihw
  bootdisk = var.boot_disk

  disks {
    scsi {
      scsi0 {
        disk {
          storage   = var.storage_location
          size      = var.node_size
          backup    = var.backup
          replicate = var.replicate
        }
      }
    }
  }
  ipconfig0               = "ip=10.3.3.5${count.index + 1}/24,gw=${var.nameserver}"
  ciuser                  = var.ciuser
  cipassword              = var.cipassword
  cloudinit_cdrom_storage = var.storage_location
  boot                    = var.boot
  nameserver              = var.nameserver
  sshkeys                 = tls_private_key.ssh_ed25519.public_key_openssh
}
