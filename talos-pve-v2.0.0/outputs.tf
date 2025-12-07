output "client_configuration" {
  value     = data.talos_client_configuration.this.talos_config
  sensitive = true
}

output "kubeconfig" {
  value     = talos_cluster_kubeconfig.this.kubeconfig_raw
  sensitive = true
}

output "kubeclientconfig" {
  value = talos_cluster_kubeconfig.this.kubernetes_client_configuration
}

output "encryption_key" {
  value = var.encryption.enabled && !var.encryption.tpm_based ? (
    var.encryption.static_key != "" ? var.encryption.static_key : random_password.encryption_key[0].result
  ) : null
  sensitive   = true
  description = "Disk encryption key (store this securely!)"
}
