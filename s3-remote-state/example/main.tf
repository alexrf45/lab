terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
  # enable remote backend once initial bucket is created. You can either back up the state
  # to itself or choose another bucket. Consult your org's risk and disaster recovery strategy
  # backend "s3" {   
  #
  # }
}

module "remote_state_backend" {
  source     = "github.com/alexrf45/lab//s3-remote-state?ref=v1.0.0" #check repo for most recent release or tag
  env        = var.env
  app        = var.app
  versioning = var.versioning
}



