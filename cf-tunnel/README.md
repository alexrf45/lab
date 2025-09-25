## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 5.10.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 5.10.1 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_dns_record.primary](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.services](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_tunnel_cloudflared) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared_config.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_tunnel_cloudflared_config) | resource |
| [random_bytes.secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/bytes) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cloudflare account ID | `string` | n/a | yes |
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | cloudflare api token | `string` | n/a | yes |
| <a name="input_app"></a> [app](#input\_app) | app or project name | `string` | `"demo"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain name for the services behind tunnel | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | code/app environement | `string` | `"testing"` | no |
| <a name="input_home_services"></a> [home\_services](#input\_home\_services) | List of services with their internal address | <pre>list(object({<br/>    subdomain   = string<br/>    service_url = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "service_url": "http://web1:8080",<br/>    "subdomain": "web1"<br/>  },<br/>  {<br/>    "service_url": "http://web2:8080",<br/>    "subdomain": "web2"<br/>  },<br/>  {<br/>    "service_url": "http://api:8080",<br/>    "subdomain": "api"<br/>  },<br/>  {<br/>    "service_url": "http://db1:9999",<br/>    "subdomain": "db1"<br/>  }<br/>]</pre> | no |
| <a name="input_primary_service_url"></a> [primary\_service\_url](#input\_primary\_service\_url) | Primary Service URL (e.g., http://service:8000 or https://internal.service.com) | `string` | `"http://localhost:8000"` | no |
| <a name="input_primary_subdomain"></a> [primary\_subdomain](#input\_primary\_subdomain) | Subdomain for primary service | `string` | `"home-lab"` | no |
| <a name="input_tunnel_name"></a> [tunnel\_name](#input\_tunnel\_name) | Name of the Cloudflare tunnel | `string` | `"home-tunnel"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Cloudflare zone ID for the domain | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cname"></a> [cname](#output\_cname) | n/a |
| <a name="output_secret"></a> [secret](#output\_secret) | n/a |
