# locals.tf - Local values for Cilium LB and node name resolution

locals {
  # Cilium L2 announcement policy and LB IP pool manifests
  cilium_external_lb_manifests = [
    {
      apiVersion = "cilium.io/v2alpha1"
      kind       = "CiliumL2AnnouncementPolicy"
      metadata = {
        name = "external"
      }
      spec = {
        loadBalancerIPs = true
        interfaces = [
          "eth0",
        ]
        nodeSelector = {
          matchExpressions = [
            {
              key      = "node-role.kubernetes.io/control-plane"
              operator = "DoesNotExist"
            },
          ]
        }
      }
    },
    {
      apiVersion = "cilium.io/v2alpha1"
      kind       = "CiliumLoadBalancerIPPool"
      metadata = {
        name = "external"
      }
      spec = {
        blocks = [
          {
            start = cidrhost(var.cilium_config.node_network, var.cilium_config.load_balancer_start)
            stop  = cidrhost(var.cilium_config.node_network, var.cilium_config.load_balancer_stop)
          },
        ]
      }
    },
  ]
  cilium_lb_manifest = join("---\n", [for d in local.cilium_external_lb_manifests : yamlencode(d)])

  # Worker node hostname map: key => hostname
  # Used by kubernetes_labels to target nodes by their Talos-assigned hostname
  worker_node_names = {
    for k, v in var.worker_nodes : k => format("${var.env}-${var.talos.name}-node-${random_id.this[k].hex}")
  }
}
