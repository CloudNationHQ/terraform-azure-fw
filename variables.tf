variable "instance" {
  description = "Contains all firewall configuration"
  type = object({
    name                = string
    resource_group_name = optional(string)
    location            = optional(string)
    sku_tier            = string
    sku_name            = string
    firewall_policy_id  = optional(string)
    dns_proxy_enabled   = optional(bool, false)
    dns_servers         = optional(list(string))
    threat_intel_mode   = optional(string)
    private_ip_ranges   = optional(list(string))
    zones               = optional(list(string))
    tags                = optional(map(string))
    virtual_hub = optional(object({
      virtual_hub_id  = string
      public_ip_count = optional(number, 1)
    }))
    management_ip_configuration = optional(object({
      name                 = string
      subnet_id            = string
      public_ip_address_id = string
    }))
    ip_configurations = optional(map(object({
      name                 = optional(string)
      subnet_id            = optional(string)
      public_ip_address_id = string
    })), {})
  })

  validation {
    condition     = var.instance.location != null || var.location != null
    error_message = "location must be provided either in the instance object or as a separate variable."
  }

  validation {
    condition     = var.instance.resource_group_name != null || var.resource_group_name != null
    error_message = "resource group name must be provided either in the instance object or as a separate variable."
  }
}

variable "naming" {
  description = "contains naming convention"
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
