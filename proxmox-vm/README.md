## Example main.tf using an s3 backend: **Please ensure to set the remote.tfbackend to the appropriate bucket, table and unique key**


```
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
    backend "s3" {}
  }
}

provider "proxmox" {
  pm_api_url          = "https://x.x.x.x:8006/api2/json"
  pm_api_token_id     = "<USER>@pve!terraform-provisioner"
  pm_api_token_secret = "<TOKEN<"
  pm_tls_insecure     = true
  pm_debug            = false
  pm_parallel         = 6
  pm_log_enable       = false
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

```

# add additional config blocks for additional vms.
```
module "dev" {
  source           = "../"
  onboot           = true
  template         = "ubuntu"
  tags             = "testing"
  scsihw           = "virtio-scsi-pci"
  description      = "testing"
  boot_disk        = "scsi0"
  storage_location = "local-lvm"
  nameserver       = "1.1.1.1"
  ciuser           = "test-user"
  cipassword       = "password"
  ssh_key_path     = "~/.ssh/lab.pub"


  vm_config = {
    v1 = {
      node    = "home-1",
      vm_id   = "9900"
      memory  = "4096",
      size    = "25",
      vm_name = "test-vm-1",
      ip      = "192.168.101.110",
    },
    v2 = {
      node    = "home-1",
      vm_id   = "9901"
      memory  = "4096",
      size    = "25",
      vm_name = "test-vm-2",
      ip      = "192.168.101.111",
    }
  }

}

```
