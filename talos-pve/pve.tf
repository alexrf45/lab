# pve.tf - Talos VM resources on Proxmox VE

resource "proxmox_virtual_environment_vm" "controlplane" {
  depends_on = [
    proxmox_virtual_environment_download_file.talos_control_plane_image
  ]
  for_each        = var.controlplane_nodes
  name            = format("${var.env}-${var.talos.name}-controlplane-${random_id.this[each.key].hex}")
  node_name       = each.value.node
  description     = "Talos Control Plane"
  tags            = ["k8s", "controlplane", "${var.env}"]
  machine         = "q35"
  scsi_hardware   = "virtio-scsi-single"
  stop_on_destroy = true
  bios            = "ovmf"
  on_boot         = true

  agent {
    enabled = true
    trim    = true
  }
  cpu {
    cores = each.value.cores
    type  = "x86-64-v2-AES"
  }
  memory {
    dedicated = each.value.memory
  }
  tpm_state {
    datastore_id = each.value.datastore_id
    version      = "v2.0"
  }
  efi_disk {
    datastore_id = each.value.datastore_id
    file_format  = "raw"
    type         = "4m"
  }
  disk {
    datastore_id = each.value.datastore_id
    interface    = "virtio0"
    file_id      = proxmox_virtual_environment_download_file.talos_control_plane_image[0].id
    file_format  = "raw"
    ssd          = true
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    size         = each.value.disk_size
  }
  disk {
    datastore_id = each.value.storage_id
    interface    = "virtio1"
    file_format  = "raw"
    ssd          = true
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    size         = each.value.storage_size
  }
  initialization {
    datastore_id = each.value.datastore_id
    dns {
      servers = [
        "${var.nameservers.primary}",
        "${var.nameservers.secondary}"
      ]
    }
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.pve.gateway
      }
    }
  }
  network_device {
    bridge = "vmbr0"
  }

  boot_order = ["virtio0"]

  operating_system {
    type = "l26"
  }

  lifecycle {
    prevent_destroy = false

    ignore_changes = [
      disk[0].file_id,
      initialization,
      description,
    ]
  }
}


resource "proxmox_virtual_environment_vm" "worker" {
  depends_on = [
    proxmox_virtual_environment_download_file.talos_worker_image
  ]
  for_each        = var.worker_nodes
  name            = format("${var.env}-${var.talos.name}-node-${random_id.this[each.key].hex}")
  node_name       = each.value.node
  description     = "Talos Worker Node"
  tags            = ["k8s", "node", "${var.env}"]
  machine         = "q35"
  scsi_hardware   = "virtio-scsi-single"
  stop_on_destroy = true
  bios            = "ovmf"
  on_boot         = true

  agent {
    enabled = true
    trim    = true
  }
  cpu {
    cores = each.value.cores
    type  = "x86-64-v2-AES"
  }
  memory {
    dedicated = each.value.memory
  }
  tpm_state {
    datastore_id = each.value.datastore_id
    version      = "v2.0"
  }
  efi_disk {
    datastore_id = each.value.datastore_id
    file_format  = "raw"
    type         = "4m"
  }
  disk {
    datastore_id = each.value.datastore_id
    interface    = "virtio0"
    file_id      = proxmox_virtual_environment_download_file.talos_worker_image[0].id
    file_format  = "raw"
    ssd          = true
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    size         = each.value.disk_size
  }
  disk {
    datastore_id = each.value.storage_id
    interface    = "virtio1"
    file_format  = "raw"
    ssd          = true
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    size         = each.value.storage_size
  }
  initialization {
    datastore_id = each.value.datastore_id
    dns {
      servers = [
        "${var.nameservers.primary}",
        "${var.nameservers.secondary}"
      ]
    }
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.pve.gateway
      }
    }
  }
  network_device {
    bridge = "vmbr0"
  }

  boot_order = ["virtio0"]

  operating_system {
    type = "l26"
  }

  lifecycle {
    prevent_destroy = false

    ignore_changes = [
      disk[0].file_id,
      initialization,
      description,
    ]
  }
}
