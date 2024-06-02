#VPS Combo


A simple vps using aws for terraform backend, hetzner cloud for infra and cloudflare for dns


## Required Providers

```
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.47.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.34.0"
    }


  }
  backend "s3" {

  }
}
```

- The vps uses cloudinit to bootstrap a debian 12 vm with a custom username, ssh key and installation of docker, vim, git, wget and curl for further configuration

- Install script is seated in the module so any changes to the script require a change to the module as of now

- utilize secure credential storage for sensitive values such as api keys required for cloudflare and hetzner
