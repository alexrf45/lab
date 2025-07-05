
data "helm_template" "this" {
  name       = "cilium"
  namespace  = "networking"
  repository = "https://helm.cilium.io/"

  chart        = "cilium"
  version      = var.cilium_version
  kube_version = "1.33.2"

  include_crds = true

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
        enabled           = true
        enableOpenMetrics = false
        metrics = {
          enabled = ["dns:query", "drop", "tcp", "flow", "port-distribution", "icmp", "http"]
        }
        relay = {
          enabled     = true
          rollOutPods = false
        }
        ui = {
          enabled = true
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
        default          = true
        enabled          = true
        loadbalancerMode = "shared"
        service = {
          externalTrafficPolicy = "Cluster"
          loadBalancerIP        = "10.3.3.41"
          name                  = "cilium-ingress"
          type                  = "LoadBalancer"
        }
      }

      gatewayAPI = {
        enabled = true
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

