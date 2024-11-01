
terraform {
  required_version = ">= 1.7.0, < 1.9.8"
  backend "s3" {

  }
}

module "app" {
  source         = "github.com/alexrf45/lab//k3s-cloudflare-tunnel?ref=dev"
  env            = "dev"
  app            = "httpbin"
  site_domain    = "fr3d.dev"
  service_domain = "http://web-service:80"
  replicas       = 2
  account_id     = var.cf_account_id
  api_token      = var.cf_api_token
}
