https://github.com/Telmate/terraform-provider-proxmox/issues/901


- Upgrading to 3.0 introduced alot of issues. This fixed it.

```hcl
# These 3 vars are present for the created cloud-init drive
  ciuser                  = "ciuser_name"
  cipassword              = "<some_password>"
  cloudinit_cdrom_storage = "local-lvm"

# The following is for making sure that when the VM get's created it knows how to boot
  boot                    = "order=scsi0;ide3"
```


## Example main.tf using an s3 backend: 
```
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

  backend "s3" {

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


module "dev" {
  source               = "github.com/alexrf45/lab.git//k3s-promox"
  etcd_count           = 2
  etcd_size            = 25
  etcd_memory          = 4096
  control_plane_count  = 2
  control_plane_memory = 4096
  control_plane_size   = 25
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

```
