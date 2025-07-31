variable "environment" {
  type        = string
  description = "Environnement de déploiement des ressources"
}

variable "storage_account_name" {
  type        = string
  description = "Nom du Storage Account External"
}

variable "location" {
  type        = string
  description = "Localisation"
  default     = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Nom du Resource Group"
}

variable "user_assigned_identity_id" {
  type        = string
  description = "ID de l'UAI"
  default     = null
}

variable "user_assigned_identity_principal_id" {
  type        = string
  description = "Principal ID de l'UAI"
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map de tags"
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Définis le type de réplication. doit être LRS, ZRS, GRS, RAGRS, GZRS"
  default     = "LRS"
}


variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2"
  default     = "StorageV2"
}

variable "https_traffic_only_enabled" {
  type        = bool
  description = "Boolean flag which forces HTTPS if enabled, see here for more information"
  default     = true
}

variable "min_tls_version" {
  type        = string
  description = "he minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts."
  default     = "TLS1_2"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether the public network access is enabled"
  default     = false
}

variable "large_file_share_enabled" {
  type        = bool
  description = "Are Large File Shares Enabled"
  default     = false
}

variable "shared_access_key_enabled" {
  type        = bool
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD)"
  default     = true
}

variable "identity_type" {
  type        = string
  description = "Type identité à activer sur la ressource ('UserAssigned' et 'SystemAssigned' sont les eules valeurs autorisées)"
  default     = "SystemAssigned"
}

variable "blob_delete_retention_policy" {
  type        = number
  description = "Specifies the number of days that the blob should be retained, between 1 and 365 days"
  default     = 14
}

variable "container_delete_retention_policy" {
  type        = number
  description = "Specifies the number of days that the container should be retained, between 1 and 365 days."
  default     = 14
}

variable "network_rules_default_action" {
  type        = string
  description = "Specifies the default action of allow or deny when no other rules match"
  default     = "Deny"
}

variable "network_rules_bypass" {
  type        = list(string)
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  default     = ["AzureServices"]
}

variable "network_rules_subnet_ids" {
  type        = list(string)
  description = "A list of resource ids for subnets."
  default     = []
}

variable "network_rules_allowed_ips" {
  type        = list(string)
  description = "List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. /31 CIDRs, /32 CIDRs, and Private IP address ranges (as defined in RFC 1918), are not allowed."
  default = [
    "194.9.96.0/20",
    "147.161.178.0/23",
    "147.161.180.0/23",
    "147.161.182.0/23",
    "77.198.202.228"
  ]
}

variable "storage_account_containers" {
  type = map(object({
    name                  = string
    container_access_type = optional(string, "container")
  }))
  description = "Container to create inside the storage account"
  default     = {}
}

variable "storage_account_file_shares" {
  type = map(object({
    name        = string
    access_tier = optional(string, "Hot")
    quota       = number
  }))
  description = "File shares to create inside the storage account"
  default     = {}
}

variable "private_endpoint_subnet_name" {
  type        = string
  description = "Subnet ou sera déployé le private endpoint"
  default     = null
}

variable "private_endpoint_virtual_network_name" {
  type        = string
  description = "VNET ou sera déployé le private endpoint"
  default     = null
}

variable "virtual_network_resource_group_name" {
  type        = string
  description = "Nom du resource group du réseau virtuel (VNET) ou sera créé le private endpoint, obligatoire si le storage account a un private endpoint"
  default     = null
}

variable "blob_versioning_enabled" {
  type        = bool
  description = "Active ou non le versionning sur les blob"
  default     = false
}

variable "cors_rule" {
  type = object({
    allowed_headers    = optional(list(string), ["*"])
    allowed_origins    = optional(list(string), ["*"])
    allowed_methods    = optional(list(string), ["*"])
    exposed_headers    = optional(list(string), ["*"])
    max_age_in_seconds = optional(number, 0)
  })

  description = <<DESCRIPTION
  A cors_rule block as defined below.

  allowed_headers: origin request.
  allowed_methods: A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
  allowed_origins: A list of origin domains that will be allowed by CORS.
  exposed_headers: A list of response headers that are exposed to CORS clients.
  max_age_in_seconds: The number of seconds the client should cache a preflight response.
  DESCRIPTION

  default = null
}