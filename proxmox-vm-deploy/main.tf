terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}

resource "tls_private_key" "ssh-ed25519" {
  algorithm = "ED25519"
}

resource "proxmox_vm_qemu" "virtual_machine" {
  for_each    = var.vm_configs
  target_node = each.value.node
  desc        = var.description
  onboot      = true

  # The template name to clone this vm from
  clone = each.value.template_name

  # Activate QEMU agent for this VM
  agent = 0

  os_type = each.value.os_type
  cores   = var.cores
  sockets = var.sockets
  numa    = true
  vcpus   = each.value.virtual_cpu
  cpu     = var.cpu_type
  memory  = each.value.memory
  name    = each.value.vm_name

  #cloudinit_cdrom_storage = "nvme"
  scsihw   = var.scsihw
  bootdisk = var.boot_disk

  disks {
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

  # Setup the ip address using cloud-init.
  # Keep in mind to use the CIDR notation for the ip.
  ipconfig0               = "ip=${each.value.ip}/24,gw=${each.value.gw}"
  ciuser                  = var.ciuser
  cipassword              = var.cipassword
  cloudinit_cdrom_storage = var.storage_location
  boot                    = var.boot
  nameserver              = each.value.nameserver
  sshkeys                 = tls_private_key.ssh-ed25519.public_key_openssh
}

