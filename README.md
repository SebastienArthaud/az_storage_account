<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_Storage_Account_container_private_endpoint"></a> [Storage\_Account\_container\_private\_endpoint](#module\_Storage\_Account\_container\_private\_endpoint) | ../azure_private_endpoint | n/a |
| <a name="module_Storage_Account_file_private_endpoint"></a> [Storage\_Account\_file\_private\_endpoint](#module\_Storage\_Account\_file\_private\_endpoint) | ../azure_private_endpoint | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.Storage_Blob_Data_Contributor_UAI_EXTERNAL](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_share.share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environnement de déploiement des ressources | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nom du Resource Group | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Nom du Storage Account External | `string` | n/a | yes |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2 | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Définis le type de réplication. doit être LRS, ZRS, GRS, RAGRS, GZRS | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid | `string` | `"Standard"` | no |
| <a name="input_blob_delete_retention_policy"></a> [blob\_delete\_retention\_policy](#input\_blob\_delete\_retention\_policy) | Specifies the number of days that the blob should be retained, between 1 and 365 days | `number` | `14` | no |
| <a name="input_blob_versioning_enabled"></a> [blob\_versioning\_enabled](#input\_blob\_versioning\_enabled) | Active ou non le versionning sur les blob | `bool` | `false` | no |
| <a name="input_container_delete_retention_policy"></a> [container\_delete\_retention\_policy](#input\_container\_delete\_retention\_policy) | Specifies the number of days that the container should be retained, between 1 and 365 days. | `number` | `14` | no |
| <a name="input_cors_rule"></a> [cors\_rule](#input\_cors\_rule) | A cors\_rule block as defined below.<br/><br/>  allowed\_headers: origin request.<br/>  allowed\_methods: A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.<br/>  allowed\_origins: A list of origin domains that will be allowed by CORS.<br/>  exposed\_headers: A list of response headers that are exposed to CORS clients.<br/>  max\_age\_in\_seconds: The number of seconds the client should cache a preflight response. | <pre>object({<br/>    allowed_headers    = optional(list(string), ["*"])<br/>    allowed_origins    = optional(list(string), ["*"])<br/>    allowed_methods    = optional(list(string), ["*"])<br/>    exposed_headers    = optional(list(string), ["*"])<br/>    max_age_in_seconds = optional(number, 0)<br/>  })</pre> | `null` | no |
| <a name="input_https_traffic_only_enabled"></a> [https\_traffic\_only\_enabled](#input\_https\_traffic\_only\_enabled) | Boolean flag which forces HTTPS if enabled, see here for more information | `bool` | `true` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Type identité à activer sur la ressource ('UserAssigned' et 'SystemAssigned' sont les eules valeurs autorisées) | `string` | `"SystemAssigned"` | no |
| <a name="input_large_file_share_enabled"></a> [large\_file\_share\_enabled](#input\_large\_file\_share\_enabled) | Are Large File Shares Enabled | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Localisation | `string` | `"westeurope"` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | he minimum supported TLS version for the storage account. Possible values are TLS1\_0, TLS1\_1, and TLS1\_2. Defaults to TLS1\_2 for new storage accounts. | `string` | `"TLS1_2"` | no |
| <a name="input_network_rules_allowed_ips"></a> [network\_rules\_allowed\_ips](#input\_network\_rules\_allowed\_ips) | List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. /31 CIDRs, /32 CIDRs, and Private IP address ranges (as defined in RFC 1918), are not allowed. | `list(string)` | <pre>[<br/>  "194.9.96.0/20",<br/>  "147.161.178.0/23",<br/>  "147.161.180.0/23",<br/>  "147.161.182.0/23",<br/>  "77.198.202.228"<br/>]</pre> | no |
| <a name="input_network_rules_bypass"></a> [network\_rules\_bypass](#input\_network\_rules\_bypass) | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None. | `list(string)` | <pre>[<br/>  "AzureServices"<br/>]</pre> | no |
| <a name="input_network_rules_default_action"></a> [network\_rules\_default\_action](#input\_network\_rules\_default\_action) | Specifies the default action of allow or deny when no other rules match | `string` | `"Deny"` | no |
| <a name="input_network_rules_subnet_ids"></a> [network\_rules\_subnet\_ids](#input\_network\_rules\_subnet\_ids) | A list of resource ids for subnets. | `list(string)` | `[]` | no |
| <a name="input_private_endpoint_subnet_name"></a> [private\_endpoint\_subnet\_name](#input\_private\_endpoint\_subnet\_name) | Subnet ou sera déployé le private endpoint | `string` | `null` | no |
| <a name="input_private_endpoint_virtual_network_name"></a> [private\_endpoint\_virtual\_network\_name](#input\_private\_endpoint\_virtual\_network\_name) | VNET ou sera déployé le private endpoint | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the public network access is enabled | `bool` | `false` | no |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD) | `bool` | `true` | no |
| <a name="input_storage_account_containers"></a> [storage\_account\_containers](#input\_storage\_account\_containers) | Container to create inside the storage account | <pre>map(object({<br/>    name                  = string<br/>    container_access_type = optional(string, "container")<br/>  }))</pre> | `{}` | no |
| <a name="input_storage_account_file_shares"></a> [storage\_account\_file\_shares](#input\_storage\_account\_file\_shares) | File shares to create inside the storage account | <pre>map(object({<br/>    name        = string<br/>    access_tier = optional(string, "Hot")<br/>    quota       = number<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map de tags | `map(string)` | `{}` | no |
| <a name="input_user_assigned_identity_id"></a> [user\_assigned\_identity\_id](#input\_user\_assigned\_identity\_id) | ID de l'UAI | `string` | `null` | no |
| <a name="input_user_assigned_identity_principal_id"></a> [user\_assigned\_identity\_principal\_id](#input\_user\_assigned\_identity\_principal\_id) | Principal ID de l'UAI | `string` | `null` | no |
| <a name="input_virtual_network_resource_group_name"></a> [virtual\_network\_resource\_group\_name](#input\_virtual\_network\_resource\_group\_name) | Nom du resource group du réseau virtuel (VNET) ou sera créé le private endpoint, obligatoire si le storage account a un private endpoint | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_account_ext_id"></a> [storage\_account\_ext\_id](#output\_storage\_account\_ext\_id) | ID du Storage Account externe |
| <a name="output_storage_container"></a> [storage\_container](#output\_storage\_container) | Information sur les containers de blob créés |
| <a name="output_storage_file_share"></a> [storage\_file\_share](#output\_storage\_file\_share) | Information sur les file share créés |
| <a name="output_storage_name"></a> [storage\_name](#output\_storage\_name) | The Name of the created Storage Account. |
| <a name="output_storage_primary_key"></a> [storage\_primary\_key](#output\_storage\_primary\_key) | The primary access key for the storage account. |
| <a name="output_storage_secondary_key"></a> [storage\_secondary\_key](#output\_storage\_secondary\_key) | The secondary access key for the storage account. |
<!-- END_TF_DOCS -->