# outputs.tf - Module outputs for talos-pve v3.1.0

output "talos_config" {
  value     = data.talos_client_configuration.this.talos_config
  sensitive = true
}

output "kubeconfig" {
  value     = talos_cluster_kubeconfig.this.kubeconfig_raw
  sensitive = true
}

output "machineconfig" {
  value     = values(talos_machine_configuration_apply.controlplane)[0].machine_configuration
  sensitive = true
}

# Outputs for provider configuration at root module level
output "kubernetes_host" {
  value     = talos_cluster_kubeconfig.this.kubernetes_client_configuration.host
  sensitive = true
}

output "kubernetes_client_certificate" {
  value     = base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.client_certificate)
  sensitive = true
}

output "kubernetes_client_key" {
  value     = base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.client_key)
  sensitive = true
}

output "kubernetes_cluster_ca_certificate" {
  value     = base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.ca_certificate)
  sensitive = true
}

# Worker node hostnames for reference
output "worker_node_names" {
  value       = local.worker_node_names
  description = "Map of worker node keys to their assigned hostnames"
}

output "post_deployment_instructions" {
  value       = <<-EOT
 
    ============================================================
    Cluster "${var.talos.name}" Deployment Complete! (v3.1.0)
    ============================================================
 
    ${var.worker_labels.enabled ? "✓ Worker node labels applied" : "⚠ Worker labeling disabled"}
 
    Verify cluster:
       kubectl --kubeconfig KUBECONFIG get nodes
 
    Merge kubeconfig (optional):
       cp ~/.kube/config ~/.kube/config_bk && \
       KUBECONFIG=~/.kube/environments/dev:~/.kube/environments/prod:~/.kube/environments/test \
       kubectl config view --flatten > ~/.kube/config_tmp && \
       mv ~/.kube/config_tmp ~/.kube/config
 
    For day-2 operations, set bootstrap_cluster = false
    to prevent bootstrap failures on subsequent applies.
 
    ============================================================
  EOT
  description = "Post-deployment instructions"
}
