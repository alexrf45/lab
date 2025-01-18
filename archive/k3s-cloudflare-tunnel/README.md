# Cloudflare Tunnel Deployment in K3s

This module deploys a simple cloudflare tunnel in kubernetes and exposes a specified service through the tunnel.


LIMFACS:

- Authentication and DNS are configured to work with cloudflare. Other providers would require a rewrite
- Tunnel stability varies on capacity. 502 errors are common with smaller nodes


Module block example with s3 remote state:
```

terraform {
  backend "s3" {

  }
}

module "app" {
  source         = "../"
  env            = "dev"
  app            = "httpbin"
  site_domain    = "fr3d.dev"
  service_domain = "http://web-service:80"
  replicas       = 2
  account_id     = ""
  api_token      = ""
}
```
