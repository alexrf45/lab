# Proxmox VM Module


## Example main.tf using an AWS s3 backend: 

*Please ensure to set the remote.tfbackend to the appropriate bucket, table and unique key*


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

# Additional config blocks for additional vms:
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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 3.0.1-rc2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 3.0.1-rc2 |

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.vm](https://registry.terraform.io/providers/Telmate/proxmox/3.0.1-rc2/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vm_config"></a> [vm\_config](#input\_vm\_config) | vm variables | `map(any)` | n/a | yes |
| <a name="input_agent"></a> [agent](#input\_agent) | enable qemu agent | `number` | `0` | no |
| <a name="input_backup"></a> [backup](#input\_backup) | whether to include drive in backups | `bool` | `true` | no |
| <a name="input_bios"></a> [bios](#input\_bios) | enable bios or efi | `string` | `"seabios"` | no |
| <a name="input_boot"></a> [boot](#input\_boot) | boot order | `string` | `"order=scsi0;ide3"` | no |
| <a name="input_boot_disk"></a> [boot\_disk](#input\_boot\_disk) | boot disk name/ID | `string` | `"scsi0"` | no |
| <a name="input_cipassword"></a> [cipassword](#input\_cipassword) | override cloud-init password | `string` | `"password1234"` | no |
| <a name="input_ciuser"></a> [ciuser](#input\_ciuser) | override default cloud-init user | `string` | `"ubuntu"` | no |
| <a name="input_cores"></a> [cores](#input\_cores) | number of virtual cores | `number` | `1` | no |
| <a name="input_description"></a> [description](#input\_description) | description of resource | `string` | `"resource"` | no |
| <a name="input_nameserver"></a> [nameserver](#input\_nameserver) | dns nameserver | `string` | `""` | no |
| <a name="input_numa"></a> [numa](#input\_numa) | not sure what it does | `bool` | `true` | no |
| <a name="input_onboot"></a> [onboot](#input\_onboot) | whether to have the vm power on after creation | `bool` | `true` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | operating system type | `string` | `"cloud-init"` | no |
| <a name="input_replicate"></a> [replicate](#input\_replicate) | whether to include drive in replication jobs | `bool` | `true` | no |
| <a name="input_scsihw"></a> [scsihw](#input\_scsihw) | type of virtual drive in use | `string` | `"virtio-scsi-pci"` | no |
| <a name="input_ssh_key_path"></a> [ssh\_key\_path](#input\_ssh\_key\_path) | file path of ssh public key | `string` | `"$HOME/.ssh/lab.pub"` | no |
| <a name="input_storage_location"></a> [storage\_location](#input\_storage\_location) | location of vm storage | `string` | `"local-lvm"` | no |
| <a name="input_vcpu"></a> [vcpu](#input\_vcpu) | number of virtual cpus | `number` | `1` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
