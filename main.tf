locals {
  private_endpoint_name = "PEP-EUR-FR-${var.environment}-${upper(var.storage_account_name)}"
}

resource "azurerm_storage_account" "storage_account" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  account_kind                  = var.account_kind
  https_traffic_only_enabled    = var.https_traffic_only_enabled
  min_tls_version               = var.min_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  large_file_share_enabled      = var.large_file_share_enabled
  shared_access_key_enabled     = var.shared_access_key_enabled #true

  dynamic "identity" {
    for_each = var.identity_type == "UserAssigned" ? toset([1]) : toset([])
    content {
      type         = var.identity_type
      identity_ids = [var.user_assigned_identity_id]
    }
  }

  blob_properties {
    versioning_enabled = var.blob_versioning_enabled
    delete_retention_policy {
      days = var.blob_delete_retention_policy
    }
    container_delete_retention_policy {
      days = var.container_delete_retention_policy
    }

    dynamic "cors_rule" {
      for_each = var.cors_rule != null ? toset([1]) : toset([])
      content {
        allowed_headers    = var.cors_rule.allowed_headers
        allowed_methods    = var.cors_rule.allowed_methods
        allowed_origins    = var.cors_rule.allowed_origins
        exposed_headers    = var.cors_rule.exposed_headers
        max_age_in_seconds = var.cors_rule.max_age_in_seconds
      }
    }
  }

  network_rules {
    default_action             = var.network_rules_default_action
    bypass                     = var.network_rules_bypass
    virtual_network_subnet_ids = var.network_rules_subnet_ids  #[]
    ip_rules                   = var.network_rules_allowed_ips #[]
  }

  tags = var.tags
}

resource "azurerm_storage_container" "container" {
  for_each              = var.storage_account_containers
  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.storage_account.id
  container_access_type = each.value.container_access_type

  depends_on = [azurerm_storage_account.storage_account]
}

resource "azurerm_storage_share" "share" {
  for_each           = var.storage_account_file_shares
  name               = each.value.name
  storage_account_id = azurerm_storage_account.storage_account.id
  access_tier        = each.value.access_tier
  quota              = each.value.quota

  depends_on = [azurerm_storage_account.storage_account]
}

resource "azurerm_role_assignment" "Storage_Blob_Data_Contributor_UAI_EXTERNAL" {
  count                = var.user_assigned_identity_principal_id != null ? 1 : 0
  scope                = azurerm_storage_account.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.user_assigned_identity_principal_id

  depends_on = [azurerm_storage_account.storage_account]
}


module "Storage_Account_file_private_endpoint" {
  count                               = var.public_network_access_enabled == false && var.storage_account_file_shares != {} ? 1 : 0
  source                              = "../azure_private_endpoint"
  private_endpoint_name               = "${local.private_endpoint_name}-file"
  subnet_name                         = var.private_endpoint_subnet_name
  virtual_network_name                = var.private_endpoint_virtual_network_name
  virtual_network_resource_group_name = var.virtual_network_resource_group_name
  resource_group_name                 = var.resource_group_name
  private_connection_resource_id      = azurerm_storage_account.storage_account.id
  subresourceType                     = "file"
}

module "Storage_Account_container_private_endpoint" {
  count                               = var.public_network_access_enabled == false && var.storage_account_containers != {} ? 1 : 0
  source                              = "../azure_private_endpoint"
  private_endpoint_name               = "${local.private_endpoint_name}-blob"
  subnet_name                         = var.private_endpoint_subnet_name
  virtual_network_name                = var.private_endpoint_virtual_network_name
  virtual_network_resource_group_name = var.virtual_network_resource_group_name
  resource_group_name                 = var.resource_group_name
  private_connection_resource_id      = azurerm_storage_account.storage_account.id
  subresourceType                     = "blob"
}
