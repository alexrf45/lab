terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  #if desired. I highly recommend it.
  backend "s3" {

  }
}

#insert your api key info below


provider "proxmox" {
  pm_api_url          = "https://192.168.101.10:8006/api2/json"
  pm_api_token_id     = "tf-user@pve!terraform-provisioner"
  pm_api_token_secret = "<api token>"
  pm_tls_insecure     = true
  pm_debug            = false
  pm_parallel         = 5
  pm_log_enable       = false
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

module "k3s" {
  source               = "github.com/alexrf45/lab.git//k3s-promox"
  etcd_count           = 3
  etcd_id              = "1001"
  etcd_size            = 25
  etcd_memory          = 4096
  control_plane_id     = ["2000", "2001"]
  control_plane_count  = 2
  control_plane_memory = 4096
  control_plane_size   = 25
  node_id              = ["1020", "1021", "1022"]
  node_count           = 3
  node_memory          = 4096
  node_size            = 25
  scsihw               = "virtio-scsi-pci"
  description          = "testing"
  boot_disk            = "scsi0"
  storage_location     = "local-lvm"
  ciuser               = "k3s"
  cipassword           = "password123"
}

