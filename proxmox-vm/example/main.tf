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


# expand the template and node based desired count and distribution of VMs
module "dev" {
  source           = "../"
  onboot           = true
  scsihw           = "virtio-scsi-pci"
  description      = "testing"
  boot_disk        = "scsi0"
  bios             = "seabios"
  agent            = 1
  storage_location = "local-lvm"
  nameserver       = "1.1.1.1"
  ciuser           = "test-user"
  cipassword       = "password"
  ssh_key_path     = "~/.ssh/lab.pub"


  vm_config = {
    v1 = {
      node     = "home-1",
      template = "ubuntu",
      tags     = "db1"
      vm_id    = "9900"
      memory   = "4096",
      size     = "25",
      vm_name  = "test-vm-1",
      ip       = "192.168.101.110",
    },
    v2 = {
      node     = "home-1",
      template = "ubuntu-cloud-init",
      tags     = "db2"
      vm_id    = "9901"
      memory   = "4096",
      size     = "25",
      vm_name  = "test-vm-2",
      ip       = "192.168.101.111",
    }
  }

}

