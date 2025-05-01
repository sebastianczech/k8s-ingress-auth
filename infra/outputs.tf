output "client_id" {
  value = azuread_application.auth.client_id
}

output "client_secret" {
  value = azuread_service_principal_password.pass.value
  sensitive = true
}