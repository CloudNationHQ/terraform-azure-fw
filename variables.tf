variable "instance" {
  description = "Contains all firewall configuration"
  type = object({
    name               = string
    resource_group     = optional(string, null)
    location           = optional(string, null)
    sku_tier           = string
    sku_name           = string
    firewall_policy_id = optional(string, null)
    dns_proxy_enabled  = optional(bool, false)
    dns_servers        = optional(list(string), null)
    threat_intel_mode  = optional(string, null)
    private_ip_ranges  = optional(list(string), null)
    zones              = optional(list(string), null)
    tags               = optional(map(string), null)
    virtual_hub = optional(object({
      virtual_hub_id  = string
      public_ip_count = optional(number, 1)
    }), null)
    management_ip_configuration = optional(object({
      name                 = string
      subnet_id            = string
      public_ip_address_id = string
    }), null)
    ip_configurations = optional(map(object({
      name                 = string
      subnet_id            = optional(string, null)
      public_ip_address_id = optional(string, null)
    })), {})
  })

  validation {
    condition     = var.instance.location != null || var.location != null
    error_message = "location must be provided either in the instance object or as a separate variable."
  }

  validation {
    condition     = var.instance.resource_group != null || var.resource_group != null
    error_message = "resource group name must be provided either in the instance object or as a separate variable."
  }
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
