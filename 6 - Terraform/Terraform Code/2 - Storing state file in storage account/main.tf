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

  subscription_id = "f721bf30-04fd-4757-a7ad-e1aeeab1a6dc"
  tenant_id = "b94db9d6-e2d9-4485-ba28-bd37e7a8d30c"
  client_id = "520c5958-2fd2-45ea-835d-dfcaa1934c0b"
  client_secret = "~VG8Q~ls_tVcyw1pOua7Pkr.cIaKjXKOs4l3jbGy"

  features {
    
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "my-rg"
  location = "West Europe"
}