variable "firewall_name" {
  description = "The name of the Azure Firewall to which the rule collections will be applied."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "The name of the resource group in which the firewall exists."
  type        = string
  default     = null
}

variable "collections" {
  description = "Contains all classic (non-policy) firewall rule collections config"
  type = object({
    network_rule_collections = optional(map(object({
      name                = optional(string)
      azure_firewall_name = optional(string)
      resource_group_name = optional(string)
      priority            = number
      action              = string
      rules = map(object({
        name                  = optional(string)
        description           = optional(string)
        protocols             = list(string)
        destination_ports     = list(string)
        source_addresses      = optional(list(string), [])
        source_ip_groups      = optional(list(string), [])
        destination_addresses = optional(list(string), [])
        destination_ip_groups = optional(list(string), [])
        destination_fqdns     = optional(list(string), [])
      }))
    })), {})
    nat_rule_collections = optional(map(object({
      name                = optional(string)
      azure_firewall_name = optional(string)
      resource_group_name = optional(string)
      priority            = number
      action              = string
      rules = map(object({
        name                  = optional(string)
        description           = optional(string)
        protocols             = list(string)
        destination_ports     = optional(list(string))
        destination_addresses = optional(list(string))
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        translated_address    = optional(string)
        translated_port       = optional(string)
      }))
    })), {})
    application_rule_collections = optional(map(object({
      name                = optional(string)
      azure_firewall_name = optional(string)
      resource_group_name = optional(string)
      priority            = number
      action              = string
      rules = map(object({
        name             = optional(string)
        description      = optional(string)
        source_addresses = optional(list(string))
        source_ip_groups = optional(list(string))
        target_fqdns     = optional(list(string))
        fqdn_tags        = optional(list(string))
        protocols = optional(list(object({
          type = string
          port = number
        })), [])
      }))
    })), {})
  })

  validation {
    condition = alltrue([
      for c in concat(
        values(var.collections.network_rule_collections),
        values(var.collections.nat_rule_collections),
        values(var.collections.application_rule_collections),
      ) : coalesce(c.azure_firewall_name, var.firewall_name, "") != ""
    ])
    error_message = "azure_firewall_name must be set on each collection or provided via the top-level firewall_name."
  }

  validation {
    condition = alltrue([
      for c in concat(
        values(var.collections.network_rule_collections),
        values(var.collections.nat_rule_collections),
        values(var.collections.application_rule_collections),
      ) : coalesce(c.resource_group_name, var.resource_group_name, "") != ""
    ])
    error_message = "resource_group_name must be set on each collection or provided via the top-level resource_group_name."
  }
}
