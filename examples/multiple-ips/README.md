# Multiple IPs

This deploys azure firewall with multiple public ip's.

## Types

```hcl
instance = object({
  resource_group    = string
  location          = string
  name              = string
  sku_name          = string
  sku_tier          = string
  dns_servers       = optional(list(string))
  dns_proxy_enabled = optional(bool)
  threat_intel_mode = optional(string)
  ip_configurations = map(object({
    name                 = string
    subnet_id            = optional(string)
    public_ip_address_id = optional(string)
  }))
})
```
