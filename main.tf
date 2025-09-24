terraform{
required_providers{
azurerm = {
source = "hashicorp/azurerm"
version = "4.1.0"
}
 
 }
}
provider "azurerm"{
features{}
subscription_id = "02a44fee-b200-4cf9-b042-9bd4aa3bebe6"
tenant_id = "63b9a1c1-375c-42cf-9c63-dc3798c7ae5e"
//client_id       = "YYYYYY-YYYY-YYYY-YYYY-YYYYYYYYY" # this is app_id
//client_secret   = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" # password
}
resource "azurerm_automation_account" "automation" {
  name                = "myAutomation"
  location            = azurerm_resource_group.azuretest_rg.location
  resource_group_name = azurerm_resource_group.azuretest_rg.name
  sku_name            = "Basic"
   # Enable system-assigned managed identity
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "automation_contributor" {
  principal_id   = azurerm_automation_account.automation.identity[0].principal_id
  role_definition_name = "Contributor"
  scope = azurerm_resource_group.azuretest_rg.id
}

resource "azurerm_automation_schedule" "daily_schedule" {
  name                    = "DailyVMStopStart"
  resource_group_name     = azurerm_resource_group.azuretest_rg.name
  automation_account_name = azurerm_automation_account.automation.name
  frequency               = "Day"
  interval                = 1
#   time_zone               = "India Standard Time"
  start_time              = "2025-09-25T22:00:00Z"  # UTC time
}
resource "azurerm_automation_job_schedule" "vm_job_schedule" {
  automation_account_name = azurerm_automation_account.automation.name
  resource_group_name     = azurerm_resource_group.azuretest_rg.name
  runbook_name            = azurerm_automation_runbook.vm_runbook.name
  schedule_name           = azurerm_automation_schedule.daily_schedule.name
}
