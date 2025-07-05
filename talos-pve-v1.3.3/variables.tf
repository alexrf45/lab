variable "pve_nodes" {
  description = "hostname/id of pve host"
  type        = list(string)
  default     = ["pve"]
}

variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name                     = string
    env                      = string
    endpoint                 = string
    pve_endpoint             = string
    vip_ip                   = string
    gateway                  = string
    talos_version            = string
    control_plane_extensions = list(string)
    worker_extensions        = list(string)
    platform                 = string
    iso_datastore            = string
    tailscale_auth           = string
  })
}


variable "nodes" {
  description = "Configuration for cluster nodes"
  type = map(object({
    install_disk     = string
    machine_type     = string
    node             = string
    ip               = string
    vm_id            = number
    datastore_id     = string
    storage_id       = string
    allow_scheduling = optional(bool, true)
    cores            = number
    memory           = number
    size             = number
    storage_size     = number
  }))
}

variable "cilium_version" {
  description = "version of cilium chart to deploy in initial talos config"
  type        = string
  default     = "v1.17.3"
}

variable "node_network" {
  description = "The IP network of the cluster nodes"
  type        = string
  default     = "10.3.3.0/24"
}


variable "load_balancer_start" {
  description = "The hostnum of the first load balancer host"
  type        = number
  default     = 50
}

variable "load_balancer_stop" {
  description = "The hostnum of the last load balancer host"
  type        = number
  default     = 59
}
