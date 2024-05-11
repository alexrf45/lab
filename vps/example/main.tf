
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }

  required_version = ">= 1.6.0"


  # remote.tfbackend or specify inputs
  backend "s3" {

  }
}


module "vps" {
  source = "git@github.com:alexrf45/lab.git//vps?ref=v0.0.1-alpha-1.0.9"

  region        = "us-west-2"
  instance_type = "t3a.medium"
  ami           = "ami-064e72469327cafbf"
  volume_size   = "50"
  username      = "fr3d"
  sg_name       = "vps_web"
}
