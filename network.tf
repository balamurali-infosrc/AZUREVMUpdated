resource "azurerm_resource_group" "azuretest_rg" {
    location = "East US"
  name = "azuretest_rg"
}

resource "azurerm_virtual_network" "azuretest_vnet" {
  name = "azuretest_vnet"
  location = azurerm_resource_group.azuretest_rg.location
resource_group_name = azurerm_resource_group.azuretest_rg.name
address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "azuretest_subnet" {
  address_prefixes = ["10.0.1.0/24"]
  name = "subnet"
  resource_group_name = azurerm_resource_group.azuretest_rg.name
  virtual_network_name = azurerm_virtual_network.azuretest_vnet.name
}