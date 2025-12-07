resource "talos_machine_secrets" "this" {
  talos_version = var.cluster.talos_version
}

data "talos_client_configuration" "this" {
  depends_on = [
    proxmox_virtual_environment_vm.talos_vm
  ]
  cluster_name         = var.cluster.name
  client_configuration = talos_machine_secrets.this.client_configuration
  nodes                = [for k, v in var.nodes : v.ip]
  endpoints            = [for k, v in var.nodes : v.ip if v.machine_type == "controlplane"]
}

data "talos_machine_configuration" "this" {
  for_each         = var.nodes
  cluster_name     = var.cluster.name
  cluster_endpoint = "https://${var.cluster.endpoint}:6443"
  talos_version    = var.cluster.talos_version
  machine_type     = each.value.machine_type
  machine_secrets  = talos_machine_secrets.this.machine_secrets

  config_patches = each.value.machine_type == "controlplane" ? [
    yamlencode(local.controlplane_configs[each.key]),
    #    yamlencode(local.tailscale_config),
    ] : [
    yamlencode(local.worker_configs[each.key]),
  ]
}


resource "talos_machine_configuration_apply" "this" {
  depends_on = [
    proxmox_virtual_environment_vm.talos_vm,
    data.talos_machine_configuration.this
  ]
  for_each                    = var.nodes
  apply_mode                  = "auto"
  node                        = each.value.ip
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.this[each.key].machine_configuration

  timeouts = {
    create = "5m"
  }
  lifecycle {
    replace_triggered_by = [proxmox_virtual_environment_vm.talos_vm[each.key]]
  }
}

resource "time_sleep" "wait_until_apply" {
  depends_on = [
    talos_machine_configuration_apply.this,
    proxmox_virtual_environment_vm.talos_vm
  ]
  create_duration = "15s"
}

#You only need to bootstrap 1 control node, we pick the first one
resource "talos_machine_bootstrap" "this" {
  depends_on = [
    time_sleep.wait_until_apply,
    proxmox_virtual_environment_vm.talos_vm,
    talos_machine_configuration_apply.this
  ]
  node                 = [for k, v in var.nodes : v.ip if v.machine_type == "controlplane"][0]
  endpoint             = var.cluster.endpoint
  client_configuration = talos_machine_secrets.this.client_configuration
  timeouts = {
    create = "3m"
  }
}

resource "time_sleep" "wait_until_bootstrap" {
  depends_on = [
    talos_machine_bootstrap.this,
    proxmox_virtual_environment_vm.talos_vm
  ]
  create_duration = "20s"
}

resource "talos_cluster_kubeconfig" "this" {
  depends_on = [
    time_sleep.wait_until_bootstrap
  ]
  node                 = [for k, v in var.nodes : v.ip if v.machine_type == "controlplane"][0]
  endpoint             = var.cluster.endpoint
  client_configuration = talos_machine_secrets.this.client_configuration
  timeouts = {
    read   = "1m"
    create = "5m"
  }
}

