variable "config" {
  description = "vm variables"
  type        = map(any)
  default = {
    count            = 1
    onboot           = true
    numa             = true
    agent            = 0
    vcpus            = 1
    cores            = 1
    sockets          = 1
    cpu_type         = "host"
    os_type          = "cloud-init"
    scsihw           = "virtio-scsi-pci"
    boot_disk        = "scsi0"
    storage_location = "local-lvm"
    boot             = "order=scsi0;ide3"
    backup           = true
    replicate        = true

    # based on local storage on each node
    control_plane_name          = "control-plane-main"
    control_plane_desc          = "control plane"
    control_plane_node          = "home-1"
    control_plane_template_name = "h1-vm"
    control_plane_memory        = 4096
    control_plane_disk_size     = 50
    node_desc                   = "node"
    node_template_name          = ""
    node_memory                 = 4096
    node_size                   = 50
    etcd_desc                   = "external etcd"
    etcd_template_name          = ""
    etcd_memory                 = 4096
    etcd_size                   = 70
    size                        = 50
    ciuser                      = "admin"
    cipassword                  = "password1234"
  }
}

# variable "node_select" {
#   description = "target node"
#   type        = map(any)
#   default = {
#
#   }
# }

