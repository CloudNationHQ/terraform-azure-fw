module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.32"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 3.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 10.0"


  vnet = {
    name                = module.naming.virtual_network.name
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
    address_space       = ["10.18.0.0/16"]

    subnets = {
      fw1 = {
        name             = "AzureFirewallSubnet"
        address_prefixes = ["10.18.0.0/26"]
      }
    }
  }
}

module "public_ip" {
  source  = "cloudnationhq/pip/azure"
  version = "~> 5.0"


  resource_group_name = module.rg.groups.demo.name
  location            = module.rg.groups.demo.location

  public_ips = {
    pub1 = {
      name  = module.naming.public_ip.name
      zones = ["1", "2", "3"]
    }
  }
}

module "firewall" {
  source  = "cloudnationhq/fw/azure"
  version = "~> 4.0"

  firewall = {
    name                = module.naming.firewall.name
    resource_group_name = module.rg.groups.demo.name
    location            = module.rg.groups.demo.location
    sku_name            = "AZFW_VNet"
    sku_tier            = "Standard"

    ip_configurations = {
      pub1 = {
        subnet_id            = module.network.subnets.fw1.id
        public_ip_address_id = module.public_ip.public_ips.pub1.id
      }
    }
  }
}

module "direct_rule_collections" {
  source  = "cloudnationhq/fw/azure//modules/direct-rule-collections"
  version = "~> 4.0"

  firewall_name       = module.firewall.firewall.name
  resource_group_name = module.rg.groups.demo.name

  collections = {
    network_rule_collections = {
      netw_rules = {
        name     = "netwrules"
        priority = 7000
        action   = "Allow"
        rules = {
          rule1 = {
            protocols             = ["TCP"]
            destination_ports     = ["*"]
            destination_addresses = ["192.168.1.0/24"]
            source_addresses      = ["10.0.0.0/8"]
          }
          rule2 = {
            protocols             = ["TCP"]
            destination_ports     = ["*"]
            destination_addresses = ["192.168.2.0/24"]
            source_addresses      = ["172.16.0.0/12"]
          }
        }
      }
    }
    nat_rule_collections = {
      nat_rules = {
        name     = "natrules"
        priority = 6500
        action   = "Dnat"
        rules = {
          rule1 = {
            protocols             = ["TCP"]
            source_addresses      = ["*"]
            destination_ports     = ["8080"]
            destination_addresses = [module.public_ip.public_ips.pub1.ip_address]
            translated_port       = "80"
            translated_address    = "10.18.1.10"
          }
        }
      }
    }
    application_rule_collections = {
      app_rules = {
        name     = "apprules"
        priority = 6000
        action   = "Allow"
        rules = {
          rule1 = {
            source_addresses = ["10.0.0.1"]
            target_fqdns     = ["*.microsoft.com"]
            protocols = [
              {
                type = "Https"
                port = 443
              }
            ]
          }
          rule2 = {
            source_addresses = ["10.0.0.1"]
            target_fqdns     = ["*.bing.com"]
            protocols = [
              {
                type = "Https"
                port = 443
              }
            ]
          }
        }
      }
    }
  }
}
