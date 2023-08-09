terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.59.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.AZURE_SUBSCRIPTION
  client_id       = var.AZURE_CLIENT_ID 
  client_secret   = var.AZURE_CLIENT_SECRET
  tenant_id       = var.AZURE_TENANT_ID
}

terraform {
  backend "azurerm" {
    resource_group_name  = "dev-tf-state-rg"
    storage_account_name = "devtfstatesa01"
    container_name       = "dev-tfstate-container"
    key                  = "dev.terraform.tfstate"
  }
}

variable "AZURE_SUBSCRIPTION" {
  type        = string
  description = "Azure Subscription ID"
  default = "e1b7cdca-1102-4a97-a25e-15fa3ea867c0"
}

variable "AZURE_CLIENT_ID" {
  type        = string
  description = "Azure Client ID"
  default = "92dbd39a-ac50-42a2-98a4-19a553c9a859"
}

variable "AZURE_CLIENT_SECRET" {
  type        = string
  description = "Azure Client Secret"
  default = ".AY8Q~W17Kaz2oB3Tep_xuA1ca2CGsDB6DOqvbU."
}

variable "AZURE_TENANT_ID" {
  type        = string
  description = "Azure Tenant ID"
  default = "3baac997-9af4-488d-8cd0-5fa8a984e7af"
}

resource "azurerm_resource_group" "default" {
  name     = "container-registry-rg"
  location = "East US 2"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "kspcontainerregistry"
  resource_group_name = azurerm_resource_group.default.name
  location            = "East US 2"
  sku                 = "Standard"
  admin_enabled       = true
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "acr_admin_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}
