resource "azurerm_network_interface" "azuretest_int" {
location = "East US"
name = "azuretest_int"
resource_group_name = azurerm_resource_group.azuretest_rg.name
ip_configuration {
  name = "Internal"
  private_ip_address_allocation = "Dynamic"
  subnet_id = azurerm_subnet.azuretest_subnet.id
}
}

resource "azurerm_windows_virtual_machine" "azuretest-vm"{
admin_password = "test@123"
admin_username = "testadmin"
location = "East US"
name = "azuretest"
network_interface_ids = [ azurerm_network_interface.azuretest_int.id ]

resource_group_name = azurerm_resource_group.azuretest_rg.name
size = "standard_D2s_v3"
os_disk {
  caching = "ReadWrite"
  storage_account_type = "StandardSSD_LRS"
}
source_image_reference {
  publisher = "MicrosoftWindowsServer"
  offer = "WindowsServer"
  sku = "2019-Datacenter"
version = "Latest"
}
}

