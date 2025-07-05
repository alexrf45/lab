resource "proxmox_virtual_environment_download_file" "talos_control_plane_image" {
  count                   = length(var.pve_nodes)
  content_type            = "iso"
  datastore_id            = var.cluster.iso_datastore
  node_name               = var.pve_nodes[count.index]
  url                     = data.talos_image_factory_urls.controlplane.urls.disk_image
  decompression_algorithm = "zst"
  file_name               = "${var.cluster.env}-control-plane-talos.img"
  overwrite               = false
  upload_timeout          = 120
}

resource "proxmox_virtual_environment_download_file" "talos_worker_image" {
  count                   = length(var.pve_nodes)
  content_type            = "iso"
  datastore_id            = var.cluster.iso_datastore
  node_name               = var.pve_nodes[count.index]
  url                     = data.talos_image_factory_urls.worker.urls.disk_image
  decompression_algorithm = "zst"
  file_name               = "${var.cluster.env}-worker-talos.img"
  overwrite               = false
  upload_timeout          = 120
}



resource "proxmox_virtual_environment_vm" "talos_vm" {
  depends_on = [
    proxmox_virtual_environment_download_file.talos_control_plane_image,
    proxmox_virtual_environment_download_file.talos_worker_image
  ]
  for_each = var.nodes
  name     = each.value.machine_type == "controlplane" ? format("${var.cluster.env}-${each.value.node}-control-plane") : format("${var.cluster.env}-${each.value.node}-node")

  node_name       = each.value.node
  description     = each.value.machine_type == "controlplane" ? "Talos Control Plane Enivornment: ${var.cluster.env}" : "Talos Worker Enivornment: ${var.cluster.env}"
  tags            = each.value.machine_type == "controlplane" ? ["k8s", "control-plane", "${var.cluster.env}"] : ["k8s", "worker", "${var.cluster.env}"]
  vm_id           = each.value.vm_id
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
    file_id      = each.value.machine_type == "controlplane" ? proxmox_virtual_environment_download_file.talos_control_plane_image[0].id : proxmox_virtual_environment_download_file.talos_worker_image[0].id
    file_format  = "raw"
    ssd          = true
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    size         = each.value.size
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
      servers = ["1.1.1.1", "8.8.8.8"]
    }
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.cluster.gateway
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
    ignore_changes = all
  }
}

