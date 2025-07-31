output "storage_account_ext_id" {
  description = "ID du Storage Account externe"
  value       = azurerm_storage_account.storage_account.id
}

output "storage_file_share" {
  description = "Information sur les file share créés"
  value       = azurerm_storage_share.share
}


output "storage_container" {
  description = "Information sur les containers de blob créés"
  value       = azurerm_storage_container.container
}

output "storage_primary_key" {
  description = "The primary access key for the storage account."
  value       = azurerm_storage_account.storage_account.primary_access_key
}

output "storage_secondary_key" {
  description = "The secondary access key for the storage account."
  value       = azurerm_storage_account.storage_account.secondary_access_key
}

output "storage_name" {
  description = "The Name of the created Storage Account."
  value       = var.storage_account_name
}