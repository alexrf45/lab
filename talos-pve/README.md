# talos-pve v3.1.0

Terraform module for provisioning Talos Linux Kubernetes clusters on Proxmox VE with integrated post-bootstrap automation.

## What's New in v3.1.0

Building on v3.0.0's independent control plane/worker scaling, v3.1.0 eliminates manual post-bootstrap steps by bringing kubeconfig export, talosconfig export, worker node labeling, and Flux CD bootstrap into the Terraform lifecycle.

### Features Added

| Feature | Replaces | Resource |
|---------|----------|----------|
| Kubeconfig file export | `terraform output -raw kubeconfig > ~/.kube/$env` | `local_sensitive_file.kubeconfig` |
| Talosconfig file export | `terraform output -raw talos_config > ~/.talos/$env` | `local_sensitive_file.talosconfig` |
| Worker node labeling | `kubectl label nodes ...` | `kubernetes_labels.worker_role` |
| SOPS age secret | `kubectl create secret generic sops-age ...` | `kubernetes_secret.sops_age` (root) |
| Flux bootstrap | `flux bootstrap git ...` | `flux_bootstrap_git.this` (root) |

### Architecture

```
root module (your infra/abydos/, infra/horus/, etc.)
├── main.tf               # Calls talos-pve-v3.1.0 module
├── providers.tf          # Configures kubernetes + flux providers from module outputs
├── flux.tf               # SOPS secret + flux_bootstrap_git (root-level, needs provider config)
├── terraform.tf          # Provider version constraints
├── variables.tf          # All variables including flux_config
├── outputs.tf            # Exposes module outputs
└── talos-pve-v3.1.0/     # The module
    ├── terraform.tf      # Module provider requirements
    ├── variables.tf      # Module inputs
    ├── outputs.tf        # Module outputs (includes kubernetes provider data)
    ├── pve.tf            # Proxmox VM resources
    ├── pve-images.tf     # Talos image downloads
    ├── talos-images.tf   # Image factory schematics
    ├── talos.tf          # Machine configs, apply, bootstrap, kubeconfig
    ├── cilium_config.tf  # Helm template for inline Cilium
    ├── locals.tf         # Cilium LB manifests, worker name map
    ├── random.tf         # Random IDs for VM naming
    ├── config-export.tf  # NEW: kubeconfig/talosconfig file export
    └── worker-labels.tf  # NEW: kubernetes_labels for worker nodes
```

### Why Flux Bootstrap is at Root Level

The `flux_bootstrap_git` resource requires the `flux` provider to be configured with both Kubernetes credentials and Git SSH credentials. Terraform providers cannot be configured inside modules using computed values, so the flux provider must be configured at the root module level where it can reference `module.cluster` outputs.

## Requirements

| Provider | Version | Purpose |
|----------|---------|---------|
| bpg/proxmox | ~> 0.93.0 | VM provisioning |
| siderolabs/talos | ~> 0.10.1 | Talos machine config & bootstrap |
| hashicorp/helm | ~> 3.0.0 | Cilium inline manifest |
| hashicorp/random | ~> 3.7.0 | Unique VM naming |
| hashicorp/time | ~> 0.11.0 | Bootstrap timing |
| hashicorp/local | ~> 2.5.0 | Config file export |
| hashicorp/kubernetes | ~> 2.36.0 | Worker labeling + SOPS secret |
| fluxcd/flux | ~> 1.5.0 | Flux bootstrap (root only) |
| hashicorp/tls | ~> 4.0.0 | SSH key management (root only) |

## Usage

```hcl
module "cluster" {
  source = "./talos-pve-v3.1.0"

  env                = "test"
  bootstrap_cluster  = true
  talos              = var.talos
  pve                = var.pve
  nameservers        = var.nameservers
  controlplane_nodes = var.controlplane_nodes
  worker_nodes       = var.worker_nodes
  cilium_config      = var.cilium_config

  # v3.1.0 features
  config_export = {
    enabled          = true
    kubeconfig_path  = "~/.kube/environments/test"
    talosconfig_path = "~/.talos/test"
  }

  worker_labels = {
    enabled = true
    labels = {
      "node-role.kubernetes.io/worker" = "true"
      "node"                           = "worker"
    }
  }
}
```

## Day-2 Operations

After initial deployment, set `bootstrap_cluster = false` to prevent bootstrap conflicts:

```hcl
bootstrap_cluster = false
```

To add workers, add entries to `worker_nodes` and run `terraform apply`. The new workers will be provisioned, configured, and labeled automatically.

To disable flux bootstrap on subsequent applies (e.g., flux manages itself after initial bootstrap):

```hcl
flux_config = {
  enabled = false
  # ... other fields still required but ignored
}
```

## Migration from v3.0.0

1. Copy the `talos-pve-v3.1.0/` directory alongside your existing module
2. Update `source` in your `main.tf` to point to `./talos-pve-v3.1.0`
3. Add the new variables: `config_export`, `worker_labels`
4. Add root-level files: `providers.tf`, `flux.tf` with provider configuration
5. Add `flux_config` variable and the flux/kubernetes/tls providers to `terraform.tf`
6. Run `terraform init -upgrade` and `terraform plan` to verify
