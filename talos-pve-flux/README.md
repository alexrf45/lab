<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_flux"></a> [flux](#requirement\_flux) | 1.4.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 6.4.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.17.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.69.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >= 0.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_flux"></a> [flux](#provider\_flux) | 1.4.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.69.0 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | >= 0.7.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Resources

| Name | Type |
|------|------|
| [flux_bootstrap_git.this](https://registry.terraform.io/providers/fluxcd/flux/1.4.0/docs/resources/bootstrap_git) | resource |
| [local_sensitive_file.controlplane_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.talosconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.worker_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [proxmox_virtual_environment_download_file.talos_image](https://registry.terraform.io/providers/bpg/proxmox/0.69.0/docs/resources/virtual_environment_download_file) | resource |
| [proxmox_virtual_environment_vm.talos_vm](https://registry.terraform.io/providers/bpg/proxmox/0.69.0/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.talos_vm_control_plane](https://registry.terraform.io/providers/bpg/proxmox/0.69.0/docs/resources/virtual_environment_vm) | resource |
| [talos_cluster_kubeconfig.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/cluster_kubeconfig) | resource |
| [talos_image_factory_schematic.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/image_factory_schematic) | resource |
| [talos_machine_bootstrap.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_bootstrap) | resource |
| [talos_machine_configuration_apply.controlplane](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration_apply.worker](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_secrets.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_secrets) | resource |
| [time_sleep.wait_until_bootstrap](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [talos_client_configuration.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/client_configuration) | data source |
| [talos_image_factory_extensions_versions.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_extensions_versions) | data source |
| [talos_image_factory_urls.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_urls) | data source |
| [talos_machine_configuration.controlplane](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/machine_configuration) | data source |
| [talos_machine_configuration.worker](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/machine_configuration) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Cluster configuration | <pre>object({<br/>    name          = string<br/>    env           = string<br/>    endpoint      = string<br/>    gateway       = string<br/>    talos_version = string<br/>    platform      = string<br/>    iso_datastore = string<br/>  })</pre> | n/a | yes |
| <a name="input_flux_extras"></a> [flux\_extras](#input\_flux\_extras) | list of additional flux components to install | `list(string)` | n/a | yes |
| <a name="input_github_pat"></a> [github\_pat](#input\_github\_pat) | GitHub Personal Access Token that is used for FluxCD provisioning | `string` | n/a | yes |
| <a name="input_node_data"></a> [node\_data](#input\_node\_data) | A map of node data | <pre>object({<br/>    controlplanes = map(object({<br/>      install_disk  = string<br/>      install_image = string<br/>      datastore_id  = string<br/>      storage_id    = string<br/>      hostname      = optional(string)<br/>      node          = string<br/>      memory        = number<br/>      size          = number<br/>      storage       = number<br/>    }))<br/>    workers = map(object({<br/>      install_disk  = string<br/>      install_image = string<br/>      datastore_id  = string<br/>      storage_id    = string<br/>      hostname      = optional(string)<br/>      node          = string<br/>      memory        = number<br/>      size          = number<br/>      storage       = number<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | Owner of the repository | `string` | `"alexrf45"` | no |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | Existing Git Repo for bootstrapping flux | `string` | `"home-ops"` | no |
| <a name="input_pve_nodes"></a> [pve\_nodes](#input\_pve\_nodes) | hostname/id of pve host | `list(string)` | <pre>[<br/>  "pve"<br/>]</pre> | no |
| <a name="input_vm_cores"></a> [vm\_cores](#input\_vm\_cores) | Number of CPU cores for the VMs | `number` | `2` | no |
| <a name="input_vm_type"></a> [vm\_type](#input\_vm\_type) | proxmox emulated CPU type, x86-64-v2-AES recommended | `string` | `"x86-64-v2-AES"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_configuration"></a> [client\_configuration](#output\_client\_configuration) | n/a |
| <a name="output_controlplane_config"></a> [controlplane\_config](#output\_controlplane\_config) | n/a |
| <a name="output_installer_disk_image"></a> [installer\_disk\_image](#output\_installer\_disk\_image) | n/a |
| <a name="output_installer_image_iso"></a> [installer\_image\_iso](#output\_installer\_image\_iso) | n/a |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | n/a |
| <a name="output_schematic_id"></a> [schematic\_id](#output\_schematic\_id) | n/a |
| <a name="output_worker_config"></a> [worker\_config](#output\_worker\_config) | n/a |
<!-- END_TF_DOCS -->