terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "0.5.4"
    }
  }
}

#=================================#
#   Define ACI Contract Filters   #
#=================================#


resource "aci_filter" "filter" {
    # for_each = var.filters
    tenant_dn = var.tenant_dn
    description = "This is filter created by terraform"
    name = "permit-all"
}


resource "aci_filter_entry" "filter_entry" {
    filter_dn = aci_filter.filter.id
    name = "permit-all"
    # ether_t = "ipv4"
    # prot = each.value.protocol
    # d_from_port = each.value.port
    # d_to_port = each.value.port
}