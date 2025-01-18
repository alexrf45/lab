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
}
