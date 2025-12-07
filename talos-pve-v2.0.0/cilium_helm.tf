resource "helm_release" "cilium" {
  depends_on = [
    talos_machine_bootstrap.this,
    talos_cluster_kubeconfig.this
  ]
  name             = "cilium"
  repository       = "https://helm.cilium.io/"
  chart            = "cilium"
  namespace        = var.cilium_config.namespace
  create_namespace = true
  wait             = false
  timeout          = 150
  version          = var.cilium_config.cilium_version

  values = [
    yamlencode({
      resources = {
        limits = {
          cpu    = "2000m"
          memory = "1Gi"
        }
        requests = {
          cpu    = "100m"
          memory = "206Mi"
        }
      }

      ipam = {
        mode = "kubernetes"
      }

      kubeProxyReplacement = true
      enableIPv6Masquerade = false
      dnsPolicy            = "ClusterFirst"

      encryption = {
        enabled        = true
        nodeEncryption = true
        type           = "wireguard"
        wireguard = {
          persistentKeepalive = "0s"
        }
      }

      l2announcements = {
        enabled = true
      }

      securityContext = {
        capabilities = {
          cleanCiliumState = ["NET_ADMIN", "SYS_ADMIN", "SYS_RESOURCE"]
          ciliumAgent      = ["CHOWN", "KILL", "NET_ADMIN", "NET_RAW", "IPC_LOCK", "SYS_ADMIN", "SYS_RESOURCE", "DAC_OVERRIDE", "FOWNER", "SETGID", "SETUID"]
        }
      }

      hubble = {
        enabled           = var.cilium_config.hubble_enabled
        enableOpenMetrics = false
        metrics = {
          enabled = ["dns:query", "drop", "tcp", "flow", "port-distribution", "icmp", "http"]
        }
        relay = {
          enabled     = var.cilium_config.relay_enabled
          rollOutPods = var.cilium_config.relay_pods_rollout
        }
        ui = {
          enabled = var.cilium_config.hubble_ui_enabled
        }
      }

      cgroup = {
        autoMount = {
          enabled = false
        }
        hostRoot = "/sys/fs/cgroup"
      }

      k8sServiceHost = "localhost"
      k8sServicePort = "7445"

      ingressController = {
        default          = var.cilium_config.ingress_default_controller
        enabled          = var.cilium_config.ingress_controller_enabled
        loadbalancerMode = var.cilium_config.load_balancer_mode
        service = {
          externalTrafficPolicy = "Cluster"
          loadBalancerIP        = var.cilium_config.load_balancer_ip
          name                  = "cilium-ingress"
          type                  = "LoadBalancer"
        }
      }

      gatewayAPI = {
        enabled = var.cilium_config.gateway_api_enabled
        gatewayClass = {
          create = "auto"
        }
      }

      redact = {
        enabled = true
        http = {
          urlQuery = true
          userInfo = true
        }
      }

      externalIPs = {
        enabled = true
      }

      k8sClientRateLimit = {
        qps   = 30
        burst = 50
      }
    })
  ]
}

# Deploy L2 announcement policy and load balancer IP pool
resource "kubectl_manifest" "cilium_l2_announcement" {
  depends_on = [helm_release.cilium]

  yaml_body = yamlencode({
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumL2AnnouncementPolicy"
    metadata = {
      name      = "external"
      namespace = var.cilium_config.namespace
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
  })
}

resource "kubectl_manifest" "cilium_lb_pool" {
  depends_on = [helm_release.cilium]

  yaml_body = yamlencode({
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumLoadBalancerIPPool"
    metadata = {
      name      = "external"
      namespace = var.cilium_config.namespace
    }
    spec = {
      blocks = [
        {
          start = cidrhost(var.cilium_config.node_network, var.cilium_config.load_balancer_start)
          stop  = cidrhost(var.cilium_config.node_network, var.cilium_config.load_balancer_stop)
        },
      ]
    }
  })
}
