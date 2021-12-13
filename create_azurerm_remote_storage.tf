# Configure the Microsoft Azure Provider
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=2.46.0"
        }
    }
}

provider "azurerm" {
    features{}
}

# Generate a random string
resource "random_string" "resource_code" {
  length = 5
  special = false
  upper = false
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name = "tfstate-rg"
  location = "southeastasia"
}

# Create a Storage Account
resource "azurerm_storage_account" "tfstate" {
  name = "tfstate${random_string.resource_code.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  tags = {
    environment = "staging"
  }
}

# Create a Storage Container to store Terraform state file
resource "azurerm_storage_container" "tfstate" {
  name = "tfstate"
  storage_account_name = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
}