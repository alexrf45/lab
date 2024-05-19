
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "proxmox_vm_qemu" "vm" {
  timeouts {
    create = "8m"
  }
  count       = var.vm_count
  tags        = var.tags
  vmid        = "${var.vm_id}${count.index}"
  name        = var.vm_name[count.index]
  target_node = var.nodes[count.index]
  desc        = var.description
  onboot      = true
  clone       = var.template[count.index]
  numa        = true
  os_type     = var.os_type
  cores       = var.cores
  vcpus       = 1
  memory      = var.memory

  #cloudinit_cdrom_storage = "nvme"
  scsihw   = var.scsihw
  bootdisk = var.boot_disk

  disks {
    scsi {
      scsi0 {
        disk {
          storage   = var.storage_location
          size      = var.size
          backup    = var.backup
          replicate = var.replicate
        }
      }
    }
  }
  ipconfig0               = var.ipconfig
  ciuser                  = var.ciuser
  cipassword              = var.cipassword
  cloudinit_cdrom_storage = var.storage_location
  boot                    = var.boot
  nameserver              = var.nameserver
  sshkeys                 = tls_private_key.ssh_key.public_key_openssh
}


