
terraform {
  backend "s3" {

  }
}

module "app" {
  source         = "../"
  env            = "dev"
  app            = "httpbin"
  subdomain      = "demo"
  site_domain    = "fr3d.dev"
  namespace      = "default"
  service_domain = "http://web-service:80"
  replicas       = 2
  account_id     = ""
  api_token      = ""
}
