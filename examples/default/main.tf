module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name
      location = "westeurope"
    }
  }
}

module "firewall" {
  source  = "cloudnationhq/fw/azure"
  version = "~> 2.0"

  instance = {
    resource_group = module.rg.groups.demo.name
    location       = module.rg.groups.demo.location
    name           = module.naming.firewall.name
    sku_name       = "AZFW_VNet"
    sku_tier       = "Standard"
  }
}
