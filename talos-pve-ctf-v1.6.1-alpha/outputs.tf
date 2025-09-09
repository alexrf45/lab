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

output "control_plane_image_url" {
  value = data.talos_image_factory_urls.controlplane.urls.disk_image
}

output "worker_image_url" {
  value = data.talos_image_factory_urls.worker.urls.disk_image
}

output "talos_machine_config" {
  value     = data.talos_machine_configuration.this[1].machine_configuration
  sensitive = true
}
