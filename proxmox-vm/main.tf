resource "proxmox_vm_qemu" "vm" {
  for_each    = var.vm_config
  vmid        = each.value.vm_id
  name        = each.value.vm_name
  target_node = each.value.node
  memory      = each.value.memory
  tags        = var.tags
  desc        = var.description
  onboot      = var.onboot
  bios        = var.bios
  clone       = var.template
  numa        = var.numa
  agent       = var.agent
  os_type     = var.os_type
  cores       = var.cores
  vcpus       = var.vcpu
  scsihw      = var.scsihw
  bootdisk    = var.boot_disk

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
          size      = each.value.size
          backup    = var.backup
          replicate = var.replicate
        }
      }
    }
  }
  ipconfig0  = "ip=${each.value.ip}/24,gw=${var.nameserver}"
  ciuser     = var.ciuser
  cipassword = var.cipassword
  boot       = var.boot
  nameserver = var.nameserver
  sshkeys    = file(var.ssh_key_path)
}


