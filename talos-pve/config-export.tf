resource "onepassword_item" "kubeconfig" {
  count      = var.config_export.enabled ? 1 : 0
  vault      = var.op_vault_id
  title      = "${var.talos.name}-kubeconfig"
  category   = "secure_note"
  note_value = talos_cluster_kubeconfig.this.kubeconfig_raw

  depends_on = [
    talos_cluster_kubeconfig.this
  ]
}

resource "onepassword_item" "talosconfig" {
  count      = var.config_export.enabled ? 1 : 0
  vault      = var.op_vault_id
  title      = "${var.talos.name}-talosconfig"
  category   = "secure_note"
  note_value = data.talos_client_configuration.this.talos_config

  depends_on = [
    talos_cluster_kubeconfig.this
  ]
}
