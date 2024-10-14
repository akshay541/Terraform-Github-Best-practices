terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.5.0"  # Ensure you use a compatible version
    }
  }
}

provider "azurerm" {
  features {}
}