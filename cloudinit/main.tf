data "cloudinit_config" "test" {
  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      users = [
        {
          name                = var.username # new username
          shell               = var.shell    #specify shell
          sudo                = "ALL=(ALL) NOPASSWD:ALL"
          ssh_authorized_keys = [var.ssh_public_key] #ssh-keygen -t ed25519 -C "vps example" -N '' -f ~/.ssh/vps
        }
      ]
    })
  }
  part { #useful for bootstrapping the instance, script can be included in
    # this module or referenced in root module.
    filename     = "./install.sh"
    content_type = "text/x-shellscript"
    content      = file(var.file_path)
  }
}

