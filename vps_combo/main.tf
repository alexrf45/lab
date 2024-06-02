
provider "cloudflare" {
  api_token = var.api_token
}

provider "hcloud" {
  token = var.hcloud_token
}

data "cloudinit_config" "bootstrap" {
  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      users = [
        {
          name                = var.username # new username
          shell               = "/bin/bash"
          sudo                = "ALL=(ALL) NOPASSWD:ALL"
          ssh_authorized_keys = [hcloud_ssh_key.access.public_key] #ssh-keygen -t ed25519 -C "web" -N '' -f ~/.ssh/web
        }
      ]
    })
  }
  part { #useful for bootstrapping the instance
    filename     = "./install.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/install.sh")
  }
}

resource "hcloud_ssh_key" "access" {
  name       = "vps_ssh"
  public_key = file(var.ssh_key_path)
}

resource "hcloud_primary_ip" "primary_ip_1" {
  name          = var.server_name
  datacenter    = var.location
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = false
  labels = {
    "IP" : "primary"
  }
}

resource "hcloud_server" "vps" {
  depends_on   = [hcloud_primary_ip.primary_ip_1]
  name         = var.server_name
  image        = var.image
  server_type  = var.server_type
  datacenter   = var.location
  firewall_ids = [hcloud_firewall.vps_fw.id]
  ssh_keys     = [hcloud_ssh_key.access.name]
  user_data    = data.cloudinit_config.bootstrap.rendered
  labels = {
    "server" : "self-hosted"
  }
  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.primary_ip_1.id
    ipv6_enabled = false
  }
}

resource "hcloud_firewall" "vps_fw" {
  name = "vps-firewall"
  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }


}

resource "hcloud_rdns" "primary1" {
  depends_on    = [hcloud_primary_ip.primary_ip_1]
  primary_ip_id = hcloud_primary_ip.primary_ip_1.id
  ip_address    = hcloud_primary_ip.primary_ip_1.ip_address
  dns_ptr       = var.dns_ptr
}

resource "cloudflare_record" "A" {
  depends_on = [hcloud_primary_ip.primary_ip_1]
  zone_id    = var.zone_id
  name       = var.dns_ptr
  value      = hcloud_primary_ip.primary_ip_1.ip_address
  type       = "A"
  ttl        = 3600
}

output "ipv4_address" {
  value = hcloud_server.vps.ipv4_address
}
