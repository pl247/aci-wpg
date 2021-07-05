terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "0.5.4"
    }
  }
}

#=================================#
#   Setup Base ACI Tenant         #
#=================================#

resource "aci_tenant" "tenant" {
  # Define a tenant to use for demonstations
  name = var.aci_tn.name
  description = var.aci_tn.description
}


resource "aci_vrf" "vrf" {
  # Define VRF with in tenant
  tenant_dn = aci_tenant.tenant.id
  name = var.aci_vrf
}

resource "aci_bridge_domain" "bridge_domain" {
  # Create Bridge domains and associate with the vrf
  for_each =  var.aci_bds

  tenant_dn = aci_tenant.tenant.id
  name = each.value.name
  description = each.value.description
  relation_fv_rs_ctx = aci_vrf.vrf.id
}

resource "aci_subnet" "bd_subnet" {
  # Associate a subnet with a bridge domain
  for_each = var.aci_bds

  parent_dn = aci_bridge_domain.bridge_domain[each.key].id
  ip = each.value.subnet
}

resource "aci_application_profile" "ap_profile" {
    # Create a basic application profile
    for_each =  var.epgs
    tenant_dn = aci_tenant.tenant.id
    name = each.value.ap_profile
}

resource "aci_application_epg" "ap_epg" {
    # Create EPGS and associate with the application profile
    for_each = var.epgs
    
    application_profile_dn = aci_application_profile.ap_profile[each.key].id
    name = each.value.name
    pref_gr_memb = "exclude"
    relation_fv_rs_bd = aci_bridge_domain.bridge_domain[each.value.bridge_domain].id
}

output "aci_tenant_out" {
  value = aci_tenant.tenant.id
}

output "aci_application_epg_out" {
  value = aci_application_epg.ap_epg
}