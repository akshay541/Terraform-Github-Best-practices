resource "azurerm_storage_management_policy" "example" {
  storage_account_id = "12345678"

  rule {
    name    = "example-rule"
    enabled = true

    filters {
      blob_types = ["blockBlob"]
      prefix_match = ["logs/"]
    }

    actions {
      base_blob {
        delete {
          days_after_modification_greater_than = 30
        }
        tier_to_archive {
          days_after_modification_greater_than = 90
        }
        tier_to_cool {
          days_after_modification_greater_than = 10
        }
      }

      snapshot {
        delete {
          days_after_creation_greater_than = 60
        }
      }
    }
  }
}