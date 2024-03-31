https://github.com/Telmate/terraform-provider-proxmox/issues/901


- Upgrading to 3.0 introduced alot of issues. This fixed it.

```hcl
# These 3 vars are there so that cloud-init drive gets created
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
  source           = "https://githubcom/alexrf45/lab.git//proxmox-vm-deploy?ref=v0.0.1-alpha"
  vm_configs       = var.vm_configs
  scsihw           = var.scsihw
  description      = var.description
  cpu_type         = var.cpu_type
  boot_disk        = var.boot_disk
  storage_location = var.storage_location
  ciuser           = var.ciuser
  cipassword       = var.cipassword
}
```
