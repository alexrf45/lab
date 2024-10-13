provider "kubernetes" {
  config_path = var.k3s_config_file_path
}

data "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_config_map" "config" {
  metadata {
    name = "${var.env}-${var.app}-cf-config"
    #namespace = kubernetes_namespace.cloudflare.metadata[0].name
    namespace = data.kubernetes_namespace.namespace.metadata[0].name
    labels = {
      "app"  = var.app
      "tier" = var.env
    }
  }
  data = {
    "config.yaml" = <<EOF
#Name of tunnel
tunnel: ${cloudflare_tunnel.dev.name}
credentials-file: /etc/cloudflared/creds/credentials.json
metrics: 0.0.0.0:2000
no-autoupdate: true
ingress:
- hostname: ${var.subdomain}.${var.site_domain}
  service: ${var.service_domain}
- service: http_status:404
EOF
  }
}

resource "kubernetes_secret" "creds" {
  metadata {
    name      = "${var.env}-${var.app}-creds"
    namespace = var.namespace
    labels = {
      "app"  = var.app
      "tier" = var.env
    }
  }
  data = {
    "credentials.json" = <<EOF
{
  "AccountTag"   : "${var.account_id}",
  "TunnelID"     : "${cloudflare_tunnel.dev.id}",
  "TunnelName"   : "${cloudflare_tunnel.dev.name}",
  "TunnelSecret" : "${random_bytes.secret.base64}"
}
EOF
  }
}
resource "kubernetes_deployment" "cloudflared" {
  depends_on = [cloudflare_tunnel.dev, cloudflare_tunnel_config.tunnel]
  timeouts {
    create = "5m"
  }
  metadata {
    name      = "${var.env}-${var.app}-cloudflared"
    namespace = var.namespace
    labels = {
      app  = var.app
      tier = var.env
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        tier = var.env
      }
    }

    template {
      metadata {
        labels = {
          tier = var.env
          app  = var.app
        }
      }
      spec {
        container {
          image = "cloudflare/cloudflared:latest"
          name  = "cloudflared"
          args  = ["tunnel", "--config", "/etc/cloudflared/config/config.yaml", "run", ]

          resources {
            limits = {
              cpu    = "500m"
              memory = "200Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "500Mi"
            }

          }
          volume_mount {
            name       = "config"
            mount_path = "/etc/cloudflared/config"
            read_only  = true
          }
          volume_mount {
            name       = "creds"
            mount_path = "/etc/cloudflared/creds"
            read_only  = true
          }

          liveness_probe {
            http_get {
              path = "/ready"
              port = 2000
            }
            failure_threshold     = 1
            initial_delay_seconds = 10
            period_seconds        = 10

          }
        }
        volume {
          name = "${var.env}-${var.app}-config"
          config_map {
            name = kubernetes_config_map.config.metadata[0].name
            items {
              key  = "config.yaml"
              path = "config.yaml"
            }
          }
        }
        volume {
          name = "${var.env}-${var.app}-creds"
          secret {
            secret_name = kubernetes_secret.creds.metadata[0].name
          }
        }
      }
    }
  }
}
