terraform {
  required_providers {
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.3"
    }
    #aws = {          specify remote state backend provider as needed
    # source  = "hashicorp/aws"
    # version = "~> 5.0"
    #}
  }
  #backend "" {

  #}
}

module "example" {
  source         = "../"
  ssh_public_key = "/home/fr3d/.ssh/vps.pub" #ssh-keygen -t ed25519 -C "vps example" -N '' -f ~/.ssh/vps
  username       = "example_user"
  shell          = "/bin/bash"
  file_path      = "./install.sh"
}
