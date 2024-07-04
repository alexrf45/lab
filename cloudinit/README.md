# Cloudinit Config Module


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | ~> 2.3.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | ~> 2.3.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudinit_config.test](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | public key used for ssh access | `string` | n/a | yes |
| <a name="input_file_path"></a> [file\_path](#input\_file\_path) | location of cloud init shell script | `string` | `"./install.sh"` | no |
| <a name="input_shell"></a> [shell](#input\_shell) | user's default shell | `string` | `"/bin/bash"` | no |
| <a name="input_username"></a> [username](#input\_username) | cloud init user | `string` | `"admin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_base64_rendered"></a> [base64\_rendered](#output\_base64\_rendered) | base64 encoded cloud init config |
| <a name="output_id"></a> [id](#output\_id) | id of cloud-init config |
| <a name="output_rendered"></a> [rendered](#output\_rendered) | the final rendered multi-part cloud init config |
<!-- END_TF_DOCS -->
