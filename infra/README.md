<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~> 3.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.auth](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_group.oauth2_proxy_users](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group_member.my_account](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group_member.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_service_principal.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.pass](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azuread_user.my_account](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_oauth2_proxy_app_name"></a> [oauth2\_proxy\_app\_name](#input\_oauth2\_proxy\_app\_name) | The display name for the OAuth2 proxy application | `string` | `"oauth2-proxy"` | no |
| <a name="input_oauth2_proxy_group_name"></a> [oauth2\_proxy\_group\_name](#input\_oauth2\_proxy\_group\_name) | The name of the security group for OAuth2 proxy users | `string` | `"oauth2-proxy-users"` | no |
| <a name="input_oauth2_proxy_homepage_url"></a> [oauth2\_proxy\_homepage\_url](#input\_oauth2\_proxy\_homepage\_url) | The homepage URL for the OAuth2 proxy application | `string` | `"https://podinfo.example.com"` | no |
| <a name="input_oauth2_proxy_redirect_uris"></a> [oauth2\_proxy\_redirect\_uris](#input\_oauth2\_proxy\_redirect\_uris) | The redirect URIs for the OAuth2 proxy application | `list(string)` | <pre>[<br/>  "https://podinfo.example.com/oauth2/callback"<br/>]</pre> | no |
| <a name="input_user_principal_name"></a> [user\_principal\_name](#input\_user\_principal\_name) | The user principal name for the account to be added to oauth2\_proxy\_users group | `string` | `"czech.sebastian_hotmail.com#EXT#_triplecrownlabs.onmicLMTCJ#EXT#@contosomarketing864.onmicrosoft.com"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_homepage"></a> [application\_homepage](#output\_application\_homepage) | Homepage URL of the Azure AD application |
| <a name="output_application_name"></a> [application\_name](#output\_application\_name) | Display name of the Azure AD application |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | Client ID of the Azure AD application |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | Client secret of the Azure AD application |
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | Group ID of the oauth2\_proxy\_users group |
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | Display name of the oauth2\_proxy\_users group |
| <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url) | OIDC issuer URL |
| <a name="output_sp_id"></a> [sp\_id](#output\_sp\_id) | Service Principal ID |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | Tenant ID of the Azure AD application |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
