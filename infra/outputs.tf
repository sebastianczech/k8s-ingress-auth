output "client_id" {
  description = "Client ID of the Azure AD application"
  value       = azuread_application.auth.client_id
}

output "client_secret" {
  description = "Client secret of the Azure AD application"
  value       = azuread_service_principal_password.pass.value
  sensitive   = true
}

output "sp_id" {
  description = "Service Principal ID"
  value       = azuread_service_principal.sp.client_id
}

output "tenant_id" {
  description = "Tenant ID of the Azure AD application"
  value       = data.azuread_client_config.current.tenant_id
}

output "group_id" {
  description = "Group ID of the oauth2_proxy_users group"
  value       = azuread_group.oauth2_proxy_users.object_id
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL"
  value       = "https://login.microsoftonline.com/${data.azuread_client_config.current.tenant_id}/v2.0"
}

output "application_name" {
  description = "Display name of the Azure AD application"
  value       = azuread_application.auth.display_name
}

output "application_homepage" {
  description = "Homepage URL of the Azure AD application"
  value       = azuread_application.auth.web[0].homepage_url
}

output "group_name" {
  description = "Display name of the oauth2_proxy_users group"
  value       = azuread_group.oauth2_proxy_users.display_name
}
