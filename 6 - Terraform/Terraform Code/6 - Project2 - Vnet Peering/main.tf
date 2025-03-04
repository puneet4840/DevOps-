resource "azurerm_resource_group" "rg" {
    name = "Learning"
    location = "West Europe"
}

resource "azurerm_virtual_network" "vnet1" {
    name = "Vnet01"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    address_space = ["10.0.0.0/16"]
    

}

resource "azurerm_subnet" "subnet-1" {
    name = "subnet-1"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes = ["10.0.0.0/24"]

}


resource "azurerm_virtual_network" "vnet2" {
    name = "Vnet02"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space = ["10.1.0.0/16"]
}


resource "azurerm_subnet" "subnet-2" {
    name = "subnet-2"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet2.name
    address_prefixes = ["10.1.0.0/24"]
}


resource "azurerm_virtual_network_peering" "vn1-to-vn2-peering" {
  name                      = "vnet01-to-vnet02-peering"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
}


resource "azurerm_virtual_network_peering" "vn2-to-vn1-peering" {
  name                      = "vnet02-tovnet01-peering"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
}