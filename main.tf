terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = ">=3.0"
        }
    }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
    name     = "my-hello-world-rg"
    location = "West US"  # Adjust location as needed
}

resource "azurerm_app_service_plan" "plan" {
    name                = "my-hello-world-plan"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    sku {
        tier = "Basic"  # Adjust tier as needed
        size = "B1"
    }
}

# Define the App Service Plan resource
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "my-traapp-service-plan"
  resource_group_name = "my-tra-group"  # Corrected resource group name
  location            = "East US"  # Adjust the location as needed

  sku {
    tier = "Basic"
    size = "B1"
  }

  kind = "Linux"

  reserved = true

  # Other configuration settings...
}



# Define the App Service resource
resource "azurerm_app_service" "app" {
  name                = "my-unique-hello-world-app"  # Choose a unique name
  resource_group_name = "my-tra-group"
  location            = "East US"  # Adjust the location as needed

  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    linux_fx_version = "NODE|20-lts"
    # Other site configuration settings...
  }
}




