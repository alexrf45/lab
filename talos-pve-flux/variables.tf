variable "flux_extras" {
  description = "list of additional flux components to install"
  type        = list(string)
}


variable "github_repository" {
  description = "Information about new GitHub repository for FluxCD"
  type = object({
    name        = string
    description = string
    visibility  = string
  })
  default = {
    name        = "fr3d"
    description = "Homelab built with Talos on Proxmox and managed with Flux"
    visibility  = "private"
  }
}

variable "github_owner" {
  description = "Owner of the repository"
  type        = string
  default     = ""
}

variable "github_pat" {
  description = "GitHub Personal Access Token that is used for FluxCD provisioning"
  type        = string
  sensitive   = true
}

variable "create_repo" {
  description = "whether to create new repository for deploying flux manifests"
  type        = bool
  default     = false
}


variable "pve_nodes" {
  description = "hostname/id of pve host"
  type        = list(string)
  default     = ["pve"]
}


variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name          = string
    endpoint      = string
    gateway       = string
    talos_version = string
    platform      = string
    iso_datastore = string
  })
}



variable "node_data" {
  description = "A map of node data"
  type = object({
    controlplanes = map(object({
      install_disk  = string
      install_image = string
      datastore_id  = string
      storage_id    = string
      hostname      = optional(string)
      node          = string
      memory        = number
      size          = number
      storage       = number
    }))
    workers = map(object({
      install_disk  = string
      install_image = string
      datastore_id  = string
      storage_id    = string
      hostname      = optional(string)
      node          = string
      memory        = number
      size          = number
      storage       = number
    }))
  })
}


variable "vm_cores" {
  description = "Number of CPU cores for the VMs"
  type        = number
  default     = 2
}


variable "vm_type" {
  description = "proxmox emulated CPU type, x86-64-v2-AES recommended"
  type        = string
  default     = "x86-64-v2-AES"
}

