# resource "proxmox_virtual_environment_download_file" "talos_control_plane_image" {
#   count                   = length(var.pve_config.hosts)
#   content_type            = "iso"
#   datastore_id            = var.pve_config.iso_datastore
#   node_name               = var.pve_config.hosts[count.index]
#   url                     = data.talos_image_factory_urls.controlplane.urls.disk_image
#   decompression_algorithm = "zst"
#   file_name               = "${var.environment}-control-plane-talos.img"
#   overwrite               = false
#   upload_timeout          = 1800
# }
#
# resource "proxmox_virtual_environment_download_file" "talos_worker_image" {
#   count                   = length(var.pve_config.hosts)
#   content_type            = "iso"
#   datastore_id            = var.pve_config.iso_datastore
#   node_name               = var.pve_config.hosts[count.index]
#   url                     = data.talos_image_factory_urls.worker.urls.disk_image
#   decompression_algorithm = "zst"
#   file_name               = "${var.environment}-worker-talos.img"
#   overwrite               = false
#   upload_timeout          = 1800
# }



resource "proxmox_virtual_environment_vm" "talos_vm" {
  # depends_on = [
  #   #proxmox_virtual_environment_download_file.talos_control_plane_image,
  #   #proxmox_virtual_environment_download_file.talos_worker_image
  # ]
  for_each        = var.nodes
  name            = each.value.machine_type == "controlplane" ? format("${var.environment}-${var.cluster.name}-cp-${random_id.example[each.key].hex}") : format("${var.environment}-${var.cluster.name}-node-${random_id.example[each.key].hex}")
  node_name       = each.value.node
  description     = each.value.machine_type == "controlplane" ? "Talos Control Plane Enivornment: ${var.environment}" : "Talos Node Enivornment: ${var.environment}"
  tags            = each.value.machine_type == "controlplane" ? ["k8s", "cp", "${var.environment}"] : ["k8s", "node", "${var.environment}"]
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
    file_id      = each.value.machine_type == "controlplane" ? "local:iso/${var.environment}-control-plane-talos.img" : "local:iso/${var.environment}-worker-talos.img"
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
    # dns {
    #   servers = [
    #     "${var.dns_servers.primary}",
    #     "${var.dns_servers.secondary}"
    #   ]
    #}
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = "10.100.30.254"
      }
    }
  }
  network_device {
    bridge   = "vmbr0"
    firewall = true
    vlan_id  = 30
  }

  boot_order = ["virtio0"]

  operating_system {
    type = "l26"
  }

  dynamic "hostpci" {
    for_each = var.pve_config.igpu ? [1] : []
    content {
      # Passthrough iGPU
      device  = "hostpci0"
      mapping = "iGPU"
      pcie    = true
      rombar  = true
      xvga    = true
    }
  }
  lifecycle {
    ignore_changes = all
  }
}

