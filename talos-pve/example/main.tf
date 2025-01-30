module "dev-test" {
  source    = "github.com/alexrf45/lab//talos-pve-flux?ref=talos-pve"
  pve_nodes = ["cairo"]

  cluster = {
    name          = "dev"
    env           = "dev"
    endpoint      = "10.3.3.60"
    pve_endpoint  = "10.3.3.9"
    gateway       = "10.3.3.1"
    talos_version = "v1.9.1"
    extensions = [
      "intel-ucode",
      "glibc",
      "iscsi-tools",
      "util-linux-tools",
      "qemu-guest-agent",
    ]
    platform      = "nocloud"
    iso_datastore = "local"
  }

  nodes = {
    v1 = {
      install_disk     = "/dev/vda"
      node             = "cairo"
      vm_id            = 7000
      datastore_id     = "data"
      allow_scheduling = optional(bool, true)
      ip               = "10.3.3.60"
      cores            = 2
      memory           = 8092
      size             = 50

    },
    v2 = {
      install_disk     = "/dev/vda"
      node             = "cairo"
      vm_id            = 7001
      datastore_id     = "data"
      allow_scheduling = optional(bool, true)
      ip               = "10.3.3.61"
      cores            = 2
      memory           = 8092
      size             = 50

    },
    v3 = {
      install_disk     = "/dev/vda"
      node             = "cairo"
      vm_id            = 7002
      datastore_id     = "data"
      allow_scheduling = optional(bool, true)
      ip               = "10.3.3.62"
      cores            = 2
      memory           = 8092
      size             = 50

    }
  }
}
