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
