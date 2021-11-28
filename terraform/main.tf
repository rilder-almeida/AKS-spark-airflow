# root

provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.serviceprinciple_id
  client_secret   = var.serviceprinciple_key
  tenant_id       = var.tenant_id

  features {}
}

module "cluster" {
  source               = "./modules/cluster/"
  serviceprinciple_id  = var.serviceprinciple_id
  serviceprinciple_key = var.serviceprinciple_key
  ssh_key              = var.ssh_key
  cluster_name         = var.cluster_name
  cluster_rg_name              = var.cluster_rg_name
  location             = var.location
  kubernetes_version   = var.kubernetes_version
}

module "storage" {
  source        = "./modules/storage/"
  sa_name       = var.sa_name
  datalake_name = var.datalake_name
  storage_rg_name       = var.storage_rg_name
  location      = var.location
}