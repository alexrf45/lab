# resource "github_repository" "this" {
#   depends_on  = [time_sleep.wait_until_bootstrap]
#   count       = var.create_repo
#   name        = var.github_repository.name
#   description = var.github_repository.description
#   visibility  = var.github_repository.visibility
#   auto_init   = true
# }

resource "flux_bootstrap_git" "this" {
  # depends_on = [
  #   github_repository.this
  # ]
  components_extra   = var.flux_extras
  embedded_manifests = true
  path               = format("clusters/%s", var.cluster.env)
  interval           = "1m0s"

}
