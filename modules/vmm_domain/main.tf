terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "0.5.4"
    }
  }
}

#=================================#
#  Associate EPGs with VMM Domain #
#=================================#

resource "aci_epg_to_domain" "epg_domain" {
  # Associate EPG to Domain
  for_each           = var.epgs
  application_epg_dn = var.epgs[each.key].id
  tdn                = var.tdn
}
