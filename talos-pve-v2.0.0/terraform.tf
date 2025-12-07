terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.80.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "~> 0.9.0-alpha.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
  # backend "s3" {
  #
  # }
}
provider "helm" {
  kubernetes = {
    host                   = try(talos_cluster_kubeconfig.this.kubernetes_client_configuration.host, "")
    client_certificate     = try(base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.client_certificate), "")
    client_key             = try(base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.client_key), "")
    cluster_ca_certificate = try(base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.ca_certificate), "")
  }
}

provider "kubectl" {
  host                   = try(talos_cluster_kubeconfig.this.kubernetes_client_configuration.host, "")
  client_certificate     = try(base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.client_certificate), "")
  client_key             = try(base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.client_key), "")
  cluster_ca_certificate = try(base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.ca_certificate), "")
  load_config_file       = false
}

