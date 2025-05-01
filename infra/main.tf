data "azuread_client_config" "current" {}

resource "azuread_application" "auth" {
  display_name     = "oauth2-proxy"
  sign_in_audience = "AzureADMyOrg"

  web {
    redirect_uris = [
      "https://podinfo.example.com/oauth2/callback",
    ]
  }
  # We don't specify any required API permissions - we allow user consent only
}

resource "azuread_service_principal" "sp" {
  client_id                    = azuread_application.auth.client_id
  app_role_assignment_required = false
}

resource "azuread_service_principal_password" "pass" {
  service_principal_id = azuread_service_principal.sp.id
}
