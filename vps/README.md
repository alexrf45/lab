# Hetzner VPS w/ Cloudflare DNS


A simple vps using aws for terraform backend, hetzner cloud for infra and cloudflare for dns

- The vps uses cloudinit to bootstrap a debian 12 vm with a custom username, ssh key and installation of docker, vim, git, wget and curl for further configuration

- Install script is seated in the module so any changes to the script require a change to the module as of now

- utilize secure credential storage for sensitive values such as api keys required for cloudflare and hetzner


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.34.0 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | ~> 2.3.3 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | 1.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 4.34.0 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.3.4 |
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | 1.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.A](https://registry.terraform.io/providers/cloudflare/cloudflare/4.34.0/docs/resources/record) | resource |
| [hcloud_firewall.vps_fw](https://registry.terraform.io/providers/hetznercloud/hcloud/1.47.0/docs/resources/firewall) | resource |
| [hcloud_primary_ip.primary_ip_1](https://registry.terraform.io/providers/hetznercloud/hcloud/1.47.0/docs/resources/primary_ip) | resource |
| [hcloud_rdns.primary1](https://registry.terraform.io/providers/hetznercloud/hcloud/1.47.0/docs/resources/rdns) | resource |
| [hcloud_server.vps](https://registry.terraform.io/providers/hetznercloud/hcloud/1.47.0/docs/resources/server) | resource |
| [hcloud_ssh_key.access](https://registry.terraform.io/providers/hetznercloud/hcloud/1.47.0/docs/resources/ssh_key) | resource |
| [cloudinit_config.bootstrap](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | cloudflare token | `string` | n/a | yes |
| <a name="input_dns_ptr"></a> [dns\_ptr](#input\_dns\_ptr) | A record to associate with primary IP | `string` | n/a | yes |
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | n/a | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | cloudflare zone id | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | iso image for vps | `string` | `"debian-12"` | no |
| <a name="input_location"></a> [location](#input\_location) | datacenter location | `string` | `"ash-dc1"` | no |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | name of server | `string` | `"vps-server"` | no |
| <a name="input_server_type"></a> [server\_type](#input\_server\_type) | instance type | `string` | `"cpx11"` | no |
| <a name="input_ssh_key_path"></a> [ssh\_key\_path](#input\_ssh\_key\_path) | path of local ssh public key to associate with vps | `string` | `"~/.ssh/vps.pub"` | no |
| <a name="input_username"></a> [username](#input\_username) | ssh user | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4_address"></a> [ipv4\_address](#output\_ipv4\_address) | n/a |
<!-- END_TF_DOCS -->
