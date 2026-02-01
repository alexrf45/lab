## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 3.0.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.93.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.7.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >= 0.9.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 3.0.0 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | ~> 0.93.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.7.0 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | >= 0.9.0 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_download_file.talos_control_plane_image](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) | resource |
| [proxmox_virtual_environment_download_file.talos_worker_image](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) | resource |
| [proxmox_virtual_environment_vm.controlplane](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.worker](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [talos_cluster_kubeconfig.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/cluster_kubeconfig) | resource |
| [talos_image_factory_schematic.controlplane](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/image_factory_schematic) | resource |
| [talos_image_factory_schematic.worker](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/image_factory_schematic) | resource |
| [talos_machine_bootstrap.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_bootstrap) | resource |
| [talos_machine_configuration_apply.controlplane](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration_apply.worker](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_secrets.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_secrets) | resource |
| [time_sleep.wait_until_apply](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_until_bootstrap](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [helm_template.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/data-sources/template) | data source |
| [talos_client_configuration.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/client_configuration) | data source |
| [talos_image_factory_extensions_versions.controlplane](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_extensions_versions) | data source |
| [talos_image_factory_extensions_versions.worker](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_extensions_versions) | data source |
| [talos_image_factory_urls.controlplane](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_urls) | data source |
| [talos_image_factory_urls.worker](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_urls) | data source |
| [talos_machine_configuration.controlplane](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/machine_configuration) | data source |
| [talos_machine_configuration.worker](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/machine_configuration) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_cluster"></a> [bootstrap\_cluster](#input\_bootstrap\_cluster) | Whether to bootstrap the cluster. Set to false after initial deployment to prevent bootstrap failures on re-apply. | `bool` | `true` | no |
| <a name="input_cilium_config"></a> [cilium\_config](#input\_cilium\_config) | Configuration options for bootstrapping cilium | <pre>object({<br/>    namespace                  = optional(string, "networking")<br/>    node_network               = string<br/>    kube_version               = string<br/>    cilium_version             = string<br/>    hubble_enabled             = optional(bool, false)<br/>    hubble_ui_enabled          = optional(bool, false)<br/>    relay_enabled              = optional(bool, false)<br/>    relay_pods_rollout         = optional(bool, false)<br/>    ingress_controller_enabled = optional(bool, true)<br/>    ingress_default_controller = optional(bool, true)<br/>    gateway_api_enabled        = optional(bool, true)<br/>    load_balancer_mode         = optional(string, "shared")<br/>    load_balancer_ip           = string<br/>    load_balancer_start        = number<br/>    load_balancer_stop         = number<br/>  })</pre> | <pre>{<br/>  "cilium_version": "1.18.0",<br/>  "gateway_api_enabled": false,<br/>  "hubble_enabled": false,<br/>  "hubble_ui_enabled": false,<br/>  "ingress_controller_enabled": true,<br/>  "ingress_default_controller": true,<br/>  "kube_version": "1.33.0",<br/>  "load_balancer_ip": "192.168.20.100",<br/>  "load_balancer_mode": "shared",<br/>  "load_balancer_start": 100,<br/>  "load_balancer_stop": 115,<br/>  "namespace": "networking",<br/>  "node_network": "192.168.20.0/24",<br/>  "relay_enabled": false,<br/>  "relay_pods_rollout": false<br/>}</pre> | no |
| <a name="input_controlplane_nodes"></a> [controlplane\_nodes](#input\_controlplane\_nodes) | Control plane node configurations - changes here won't affect workers | <pre>map(object({<br/>    node             = string<br/>    ip               = string<br/>    cores            = optional(number, 2)<br/>    memory           = optional(number, 8192)<br/>    allow_scheduling = optional(bool, false)<br/>    datastore_id     = optional(string, "local-lvm")<br/>    storage_id       = string<br/>    disk_size        = optional(number, 50)<br/>    storage_size     = optional(number, 100)<br/>  }))</pre> | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Operating env of cluster (dev, test, prod) | `string` | n/a | yes |
| <a name="input_nameservers"></a> [nameservers](#input\_nameservers) | DNS servers for the nodes | <pre>object({<br/>    primary   = string<br/>    secondary = string<br/>  })</pre> | <pre>{<br/>  "primary": "1.1.1.1",<br/>  "secondary": "8.8.8.8"<br/>}</pre> | no |
| <a name="input_pve"></a> [pve](#input\_pve) | Proxmox VE configuration options | <pre>object({<br/>    hosts         = list(string)<br/>    endpoint      = string<br/>    iso_datastore = optional(string, "local")<br/>    gateway       = string<br/>    password      = string<br/><br/>  })</pre> | n/a | yes |
| <a name="input_talos"></a> [talos](#input\_talos) | Cluster configuration | <pre>object({<br/>    name                     = optional(string, "k8s-cluster")<br/>    endpoint                 = string<br/>    vip_ip                   = string<br/>    version                  = string<br/>    install_disk             = optional(string, "/dev/vda")<br/>    storage_disk             = optional(string, "/var/data")<br/>    control_plane_extensions = list(string)<br/>    worker_extensions        = list(string)<br/>    platform                 = optional(string, "nocloud")<br/>  })</pre> | n/a | yes |
| <a name="input_worker_nodes"></a> [worker\_nodes](#input\_worker\_nodes) | Worker node configurations - can be scaled independently without affecting control plane | <pre>map(object({<br/>    node         = string<br/>    ip           = string<br/>    cores        = optional(number, 2)<br/>    memory       = optional(number, 8092)<br/>    datastore_id = optional(string, "local-lvm")<br/>    storage_id   = string<br/>    disk_size    = optional(number, 50)<br/>    storage_size = optional(number, 200)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
| <a name="output_machineconfig"></a> [machineconfig](#output\_machineconfig) | n/a |
| <a name="output_post_deployment_instructions"></a> [post\_deployment\_instructions](#output\_post\_deployment\_instructions) | Post-deployment instructions |
| <a name="output_talos_config"></a> [talos\_config](#output\_talos\_config) | n/a |
