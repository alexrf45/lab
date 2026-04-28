resource "kubernetes_labels" "worker_role" {
  for_each = var.worker_labels.enabled ? var.worker_nodes : {}

  depends_on = [
    talos_cluster_kubeconfig.this,
    talos_machine_configuration_apply.worker,
    time_sleep.wait_until_bootstrap,
  ]

  api_version = "v1"
  kind        = "Node"

  metadata {
    name = local.worker_node_names[each.key]
  }

  labels = var.worker_labels.labels

  force = true
}
