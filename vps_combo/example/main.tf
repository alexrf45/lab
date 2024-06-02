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


module "vps" {
  source       = "github.com/alexrf45/lab.git//vps_combo?ref=vps"
  hcloud_token = ""
  username     = ""
  api_token    = ""
  zone_id      = ""
  ssh_key_path = ""
  image        = ""
  server_name  = ""
  server_type  = ""
  location     = ""
  dns_ptr      = ""

}
