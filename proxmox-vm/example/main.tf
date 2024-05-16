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
  }

  #if desired. I highly recommend it. 
  backend "s3" {

  }
}

#insert your api key info below

provider "proxmox" {
  pm_api_url          = "https://10.X.X.X:8006/api2/json"
  pm_api_token_id     = ""
  pm_api_token_secret = ""
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
  vm_count         = 2
  size             = 25
  memory           = 4096
  template         = ["h1-vm", "h2-vm"]
  nodes            = ["home-1", "home-2"]
  scsihw           = "virtio-scsi-pci"
  description      = "testing"
  boot_disk        = "scsi0"
  storage_location = "local-lvm"
  cidr             = "10.3.3.3"
  nameserver       = "10.3.3.1"
  ciuser           = "k3s"
  cipassword       = "password123"
}

output "private-key" {
  value     = module.dev.private-key
  sensitive = true
}
