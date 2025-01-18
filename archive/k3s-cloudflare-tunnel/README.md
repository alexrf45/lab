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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 4.30.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.30.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 4.30.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.30.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.cname](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_tunnel.dev](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/tunnel) | resource |
| [cloudflare_tunnel_config.tunnel](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/tunnel_config) | resource |
| [kubernetes_config_map.config](https://registry.terraform.io/providers/hashicorp/kubernetes/2.30.0/docs/resources/config_map) | resource |
| [kubernetes_deployment.cloudflared](https://registry.terraform.io/providers/hashicorp/kubernetes/2.30.0/docs/resources/deployment) | resource |
| [kubernetes_secret.creds](https://registry.terraform.io/providers/hashicorp/kubernetes/2.30.0/docs/resources/secret) | resource |
| [random_bytes.secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/bytes) | resource |
| [cloudflare_zones.domain](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zones) | data source |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.30.0/docs/data-sources/namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | cloudflare api token | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | code/app environement | `string` | n/a | yes |
| <a name="input_service_domain"></a> [service\_domain](#input\_service\_domain) | domain of k3s service i.e http://web-service:80 | `string` | n/a | yes |
| <a name="input_site_domain"></a> [site\_domain](#input\_site\_domain) | domain name of specified zone | `string` | n/a | yes |
| <a name="input_app"></a> [app](#input\_app) | app or project name | `string` | `""` | no |
| <a name="input_k3s_config_file_path"></a> [k3s\_config\_file\_path](#input\_k3s\_config\_file\_path) | file path for kube config | `string` | `"~/.kube/config"` | no |
| <a name="input_proxied"></a> [proxied](#input\_proxied) | whether to proxy dns through cloudflare | `bool` | `true` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | number of replicas for cloudflare deployment | `number` | `2` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cname"></a> [cname](#output\_cname) | n/a |
| <a name="output_secret"></a> [secret](#output\_secret) | n/a |
| <a name="output_service_record"></a> [service\_record](#output\_service\_record) | n/a |
| <a name="output_tunnel_token"></a> [tunnel\_token](#output\_tunnel\_token) | n/a |
<!-- END_TF_DOCS -->