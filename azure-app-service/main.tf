# Configure the Microsoft Azure Provider
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">=2.26"
        }
    }

    required_version = ">=0.13"    

    # Specify remote backend storage to store Terraform state file on Azure Blob storage
    backend azurerm {
        resource_group_name = "tfstate-rg"
        storage_account_name = "tfstateicfq7"
        container_name = "tfstate"        
        key = "terraform.tfstate"        
    }
}

provider "azurerm" {
    features{}
}

# Generate a random string
resource "random_string" "webappsuffix" {
  length = 5
  special = false
  upper = false
}

# Create a new Resource Group
resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.resource_group_location
    tags = var.tags
}

# Create a new App Service plan for Web Apps running on a Linux container
resource "azurerm_app_service_plan" "asp" {
    name = "tailspin-space-game-asp"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    kind = "Linux"
    reserved = true

    sku {
       tier = "Basic"
       size = "B1"
    }
}

resource "azurerm_app_service" "web-dev" {
    name = "tailspin-space-game-web-dev-${random_string.webappsuffix.result}"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    app_service_plan_id = azurerm_app_service_plan.asp.id
}

resource "azurerm_app_service" "web-test" {
    name = "tailspin-space-game-web-test-${random_string.webappsuffix.result}"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    app_service_plan_id = azurerm_app_service_plan.asp.id
}

resource "azurerm_app_service" "web-prod" {
    name = "tailspin-space-game-web-prod-${random_string.webappsuffix.result}"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    app_service_plan_id = azurerm_app_service_plan.asp.id
}
