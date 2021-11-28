# root/storage

resource "azurerm_resource_group" "storage-rg" {
  name     = var.datalake_rg_name
  location = var.location
}

resource "azurerm_storage_account" "aks-sa" {
  name                     = var.sa_name
  resource_group_name      = azurerm_resource_group.storage-rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "aks-datalake" {
  name               = var.datalake_name
  storage_account_id = azurerm_storage_account.aks-sa.id
}