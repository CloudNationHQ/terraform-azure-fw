# Complete

This example highlights the complete usage.

## Types

```hcl
instance = object({
  name              = string
  resource_group    = string
  location          = string
  sku_name          = string
  sku_tier          = string
  dns_servers       = optional(list(string))
  dns_proxy_enabled = optional(bool)
  threat_intel_mode = optional(string)
  private_ip_ranges = optional(list(string))
  zones             = optional(list(number))
  ip_configurations = optional(map(object({
    name                 = string
    subnet_id            = optional(string)
    public_ip_address_id = optional(string)
  })))
  management_ip_configuration = optional(object({
    name                 = string
    subnet_id            = string
    public_ip_address_id = string
  }))
})
```
