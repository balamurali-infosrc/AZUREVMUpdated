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

