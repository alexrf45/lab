# terraform.tf - Provider requirements for talos-pve v3.1.0
terraform {
  required_version = ">= 1.9.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.93.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "~> 0.10.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.11.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "3.2.1"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.7.6"
    }

  }
}
