# Azure Storage Account resource
resource "azurerm_storage_account" "storage" {
  name                     = "${var.resource_group_name}-storage"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = true

  # Add tags for resource management
  tags = merge(var.default_tags, var.extra_tags)

  # Version of this module (semantic version reference)
  version = var.module_version

  lifecycle {
    prevent_destroy = var.prevent_destroy
  }
}

# Lifecycle Management Rules using for_each and list/dict of rules
resource "azurerm_storage_management_policy" "policy" {
  storage_account_id = azurerm_storage_account.storage.id

  # Use for_each to create multiple lifecycle rules
  rule {
    for_each = { for rule in var.lifecycle_rules : rule.name => rule }

    name = each.key

    enabled = each.value.enabled

    filters {
      blob_types = each.value.blob_types

      prefix_match = each.value.prefix_match != null ? each.value.prefix_match : []
    }

    actions {
      base_blob {
        delete {
          days_after_modification_greater_than = each.value.delete_after_days
        }

        tier_to_archive {
          days_after_modification_greater_than = each.value.archive_after_days
        }

        tier_to_cool {
          days_after_modification_greater_than = each.value.cool_after_days
        }
      }
    }
  }
}
