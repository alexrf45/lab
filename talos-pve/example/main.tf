module "cluster" {
  source = "git@github.com:alexrf45/lab.git//talos-pve?ref=v3.1.0"

  env                = var.env
  bootstrap_cluster  = var.bootstrap_cluster
  talos              = var.talos
  pve                = var.pve
  nameservers        = var.nameservers
  controlplane_nodes = var.controlplane_nodes
  worker_nodes       = var.worker_nodes
  cilium_config      = var.cilium_config
  config_export      = var.config_export
  worker_labels      = var.worker_labels
}

resource "kubernetes_secret" "sops_age" {
  count = var.flux_config.enabled ? 1 : 0

  depends_on = [
    module.cluster,
  ]

  metadata {
    name      = var.flux_config.sops_secret_name
    namespace = "flux-system"
  }

  data = {
    "${var.flux_config.sops_age_key_name}" = file(pathexpand(var.flux_config.sops_age_key_path))
  }

  type = "Opaque"

  lifecycle {
    # Prevent replacement if the secret already exists from a prior bootstrap
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels,
    ]
  }
}

#############################
# Flux Bootstrap
#############################
resource "flux_bootstrap_git" "this" {
  count = var.flux_config.enabled ? 1 : 0

  depends_on = [
    module.cluster,
    kubernetes_secret.sops_age,
  ]

  cluster_domain     = var.flux_config.cluster_domain
  path               = var.flux_config.cluster_path
  embedded_manifests = true
}
