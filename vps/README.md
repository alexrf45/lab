# AWS Virtual Private Server

- A simple module for spinning up an EC2 instance for general use

## Required providers


```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.49.0"
    }
  }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.5"
    }
  cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.3"
    }

}



