# AWS Virtual Private Server

- A simple module for spinning up an EC2 instance for general use

- See example folder for module use

- Module is built assuming deployment is initialized from local machine. Development for use on runners is not in the works at this time

- Install script is still in testing. ensure install script is located in parent directory before deploying

## Provider block:

```hcl
provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      Name      = "AWS Virtual Private Server"
      Purpose   = "Virtual Private Server"
      ManagedBy = "Terraform"
    }
  }
}
provider "tls" {

}

provider "cloudinit" {

}
```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | ~> 2.3.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | ~> 2.3.3 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.eip_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_instance.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.ssh_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group.web_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ssh_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [cloudinit_config.test](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | code/app environement | `string` | n/a | yes |
| <a name="input_ami"></a> [ami](#input\_ami) | Amazon Machine Image | `string` | `"ami-052efd3df9dad4825"` | no |
| <a name="input_app"></a> [app](#input\_app) | app or project name | `string` | `""` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whether to associate public IP to EC2 Instance | `bool` | `true` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 Instance type | `string` | `"t3a.medium"` | no |
| <a name="input_region"></a> [region](#input\_region) | aws region | `string` | `"us-east-1"` | no |
| <a name="input_sg_description"></a> [sg\_description](#input\_sg\_description) | Description of security group | `string` | `"SSH & HTTP/HTTPS"` | no |
| <a name="input_sg_name"></a> [sg\_name](#input\_sg\_name) | Name of security group | `string` | `"bounty_sg"` | no |
| <a name="input_username"></a> [username](#input\_username) | username for vps instance | `string` | `""` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of Volume | `string` | `"50"` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Type of volume | `string` | `"gp2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the instance |
| <a name="output_ssh_key"></a> [ssh\_key](#output\_ssh\_key) | ssh private key for ssh access |
| <a name="output_vps_public_ip"></a> [vps\_public\_ip](#output\_vps\_public\_ip) | public ip from Elastic IP allocation |
<!-- END_TF_DOCS -->