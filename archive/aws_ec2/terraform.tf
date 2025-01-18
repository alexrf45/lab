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
    # tls = {    required to generate a new ssh key for access
    #   source  = "hashicorp/tls"
    #   version = "4.0.5"
    # }
  }

  required_version = ">= 1.7.0"


  # remote.tfbackend or specify inputs
  # backend "s3" {

  #}
}
