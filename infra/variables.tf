variable "user_principal_name" {
  description = "The user principal name for the account to be added to oauth2_proxy_users group"
  type        = string
  default     = "czech.sebastian_hotmail.com#EXT#_triplecrownlabs.onmicLMTCJ#EXT#@contosomarketing864.onmicrosoft.com"
}

variable "oauth2_proxy_app_name" {
  description = "The display name for the OAuth2 proxy application"
  type        = string
  default     = "oauth2-proxy"
}

variable "oauth2_proxy_homepage_url" {
  description = "The homepage URL for the OAuth2 proxy application"
  type        = string
  default     = "https://podinfo.example.com"
}

variable "oauth2_proxy_redirect_uris" {
  description = "The redirect URIs for the OAuth2 proxy application"
  type        = list(string)
  default     = ["https://podinfo.example.com/oauth2/callback"]
}

variable "oauth2_proxy_group_name" {
  description = "The name of the security group for OAuth2 proxy users"
  type        = string
  default     = "oauth2-proxy-users"
}
