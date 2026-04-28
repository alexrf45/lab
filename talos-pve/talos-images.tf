# talos-images.tf - Talos image factory schematics
data "talos_image_factory_extensions_versions" "controlplane" {
  talos_version = var.talos.version
  filters = {
    names = var.talos.control_plane_extensions
  }
}

data "talos_image_factory_urls" "controlplane" {
  talos_version = var.talos.version
  schematic_id  = talos_image_factory_schematic.controlplane.id
  platform      = var.talos.platform
}

resource "talos_image_factory_schematic" "controlplane" {
  schematic = yamlencode(
    {
      customization = {
        systemExtensions = {
          officialExtensions = data.talos_image_factory_extensions_versions.controlplane.extensions_info.*.name
        }
      }
    }
  )
}

data "talos_image_factory_extensions_versions" "worker" {
  talos_version = var.talos.version
  filters = {
    names = var.talos.worker_extensions
  }
}

data "talos_image_factory_urls" "worker" {
  talos_version = var.talos.version
  schematic_id  = talos_image_factory_schematic.worker.id
  platform      = var.talos.platform
}

resource "talos_image_factory_schematic" "worker" {
  schematic = yamlencode(
    {
      customization = {
        systemExtensions = {
          officialExtensions = data.talos_image_factory_extensions_versions.worker.extensions_info.*.name
        }
      }
    }
  )
}
