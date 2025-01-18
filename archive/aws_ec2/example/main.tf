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


#uncomment to create
# resource "tls_private_key" "ssh_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }
#
#
provider "aws" {
  region = "us-west-2"
}

module "example" {
  source                      = "../"
  region                      = "us-west-2"
  env                         = "dev"
  app                         = "example"
  file_path                   = "./install.sh"
  username                    = "test"
  shell                       = "/bin/bash"
  ssh_key_path                = file("~/.ssh/vps.pub") #or tls_private_key.ssh_key.public_key_openssh
  instance_type               = "t3a.micro"
  ami                         = "ami-0aff18ec83b712f05"
  volume_size                 = "30"
  associate_public_ip_address = true
  sg_name                     = "example"
  sg_description              = "example"
}
