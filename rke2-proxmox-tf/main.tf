
resource "tls_private_key" "ssh_ed25519" {
  algorithm = "ED25519"
}

resource "proxmox_vm_qemu" "control-plane" {
  count       = var.config.count
  target_node = var.config.control_plane_node
  desc        = var.config.control_plane_desc
  onboot      = var.config.onboot

  # The template name to clone this vm from
  clone = var.config.control_plane_template_name

  # Activate QEMU agent for this VM

  os_type = var.config.os_type
  cores   = var.config.cores
  sockets = var.config.sockets
  numa    = var.config.numa
  vcpus   = var.config.vcpus
  cpu     = var.config.cpu_type
  memory  = var.config.control_plane_memory
  name    = var.config.control_plane_name

  #cloudinit_cdrom_storage = "nvme"
  scsihw   = var.config.scsihw
  bootdisk = var.config.boot_disk

  disks {
    scsi {
      scsi0 {
        disk {
          storage   = var.config.storage_location
          size      = var.config.control_plane_disk_size
          backup    = var.config.backup
          replicate = var.config.replicate
        }
      }
    }
  }
  #If static IPs are not a concern
  # network {
  #   model    = "virtio"
  #   bridge   = var.bridge
  #   firewall = false
  # }
  # Setup the ip address using cloud-init.
  # Keep in mind to use the CIDR notation for the ip.
  ipconfig0               = "ip=${var.config.control_plane_cidr}${count.index + 1}/24,gw=${var.config.gw}"
  ciuser                  = var.config.ciuser
  cipassword              = var.config.cipassword
  cloudinit_cdrom_storage = var.config.storage_location
  boot                    = var.config.boot
  sshkeys                 = tls_private_key.ssh_ed25519.public_key_openssh
}



