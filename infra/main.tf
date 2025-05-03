# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config
data "azuread_client_config" "current" {}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application
resource "azuread_application" "auth" {
  display_name     = "oauth2-proxy"
  sign_in_audience = "AzureADMyOrg"

  group_membership_claims = [
    "SecurityGroup"
  ]

  # we don't specify any required API permissions - we allow user consent only
  web {
    homepage_url = "https://podinfo.example.com"
    redirect_uris = [
      "https://podinfo.example.com/oauth2/callback",
    ]
  }

  # solution for problem: Error retrieving session from token in Authorization header: [unable to verify bearer token, failed to verify token: oidc: id token issued by a different provider, expected "https://login.microsoftonline.com/dca11c8d-6718-4495-b1a7-46217af67c69/v2.0" got "https://sts.windows.net/dca11c8d-6718-4495-b1a7-46217af67c69/"]
  api {
    requested_access_token_version = 2
  }
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal
resource "azuread_service_principal" "sp" {
  client_id                    = azuread_application.auth.client_id
  app_role_assignment_required = false
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password
resource "azuread_service_principal_password" "pass" {
  service_principal_id = azuread_service_principal.sp.id
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group
resource "azuread_group" "oauth2_proxy_users" {
  display_name     = "oauth2-proxy-users"
  security_enabled = true
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user
data "azuread_user" "my_account" {
  user_principal_name = "czech.sebastian_hotmail.com#EXT#_triplecrownlabs.onmicLMTCJ#EXT#@contosomarketing864.onmicrosoft.com"
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member
resource "azuread_group_member" "my_account" {
  group_object_id  = azuread_group.oauth2_proxy_users.object_id
  member_object_id = data.azuread_user.my_account.object_id
}

resource "azuread_group_member" "sp" {
  group_object_id  = azuread_group.oauth2_proxy_users.object_id
  member_object_id = azuread_service_principal.sp.object_id
}
