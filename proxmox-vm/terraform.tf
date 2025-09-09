terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc04"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

  }
}
