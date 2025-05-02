# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config
data "azuread_client_config" "current" {}

# # https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application_published_app_ids
# data "azuread_application_published_app_ids" "well_known" {}

# # https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal
# resource "azuread_service_principal" "msgraph" {
#   client_id    = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
#   use_existing = true
# }

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

  # api {
  #   mapped_claims_enabled          = true
  #   requested_access_token_version = 2

  #   oauth2_permission_scope {
  #     admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
  #     admin_consent_display_name = "Access example"
  #     enabled                    = true
  #     id                         = "96183846-204b-4b43-82e1-5d2222eb4b9b"
  #     type                       = "User"
  #     user_consent_description   = "Allow the application to access example on your behalf."
  #     user_consent_display_name  = "Access example"
  #     value                      = "user_impersonation"
  #   }

  #   oauth2_permission_scope {
  #     admin_consent_description  = "Administer the example application"
  #     admin_consent_display_name = "Administer"
  #     enabled                    = true
  #     id                         = "be98fa3e-ab5b-4b11-83d9-04ba2b7946bc"
  #     type                       = "Admin"
  #     value                      = "administer"
  #   }
  # }

  # required_resource_access {
  #   resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph

  #   resource_access {
  #     id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["openid"]
  #     type = "Scope"
  #   }

  #   resource_access {
  #     id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read"]
  #     type = "Scope"
  #   }
  # }
}

# # https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_delegated_permission_grant
# resource "azuread_service_principal_delegated_permission_grant" "permission" {
#   service_principal_object_id          = azuread_service_principal.sp.object_id
#   resource_service_principal_object_id = azuread_service_principal.msgraph.object_id
#   claim_values                         = ["openid", "User.Read.All"]
# }

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
