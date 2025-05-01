terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.3.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "azuread" {
}
