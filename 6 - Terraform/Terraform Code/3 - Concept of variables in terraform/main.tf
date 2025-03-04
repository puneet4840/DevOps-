terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }

  backend "azurerm" {
      resource_group_name  = "Learning"
      storage_account_name = "terraformpuneet"
      container_name       = "terraform-blob"
      key                  = "terraform.tfstate"
      access_key           = "BzyGlaQa9ccnXlEzl8hHuGrCTUyinZhGWDz4LaSATxihSIyPCyabjAOgftRb4C0ORpCmi1QCdF/I+AStFipBcg=="
  }

}


provider "azurerm" {
  # Configuration options

  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  client_id = var.client_id
  client_secret = var.client_secret

  features {
    
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.azure_rm_resource_group_name
  location = var.azure_rm_location_name
}
