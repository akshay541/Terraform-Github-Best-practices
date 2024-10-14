resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacct"
  resource_group_name       = "rg-name"
  location                  = "eu-west-2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
}

module "storage_management_policy" {
  source               = "./modules/storage_management_policy"
  storage_account_id   = "12345678"
  rule_name            = "log-cleanup"
  blob_types           = ["blockBlob"]
  prefix_match         = ["logs/"]
  delete_after_days    = 30
  archive_after_days   = 90
  cool_after_days      = 10
  delete_after_days_snapshots = 60
}