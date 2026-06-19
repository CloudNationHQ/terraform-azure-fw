locals {
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
            destination_addresses = [module.public_ip.configs.pub1.ip_address]
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
