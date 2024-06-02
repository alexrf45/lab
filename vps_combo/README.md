#VPS Combo


A simple vps using aws for terraform backend, hetzner cloud for infra and cloudflare for dns


## Provider

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
