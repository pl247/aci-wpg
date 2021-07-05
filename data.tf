# data "aci_tenant" "tenant" {
#   name = var.aci_tn.name
# }

# data "aci_application_profile" "ap_profile" {
#   for_each  = var.epgs
#   tenant_dn = data.aci_tenant.tenant.id
#   name      = each.value.ap_profile
# }

# data "aci_application_epg" "ap_epg" {
#   for_each               = var.epgs
#   application_profile_dn = data.aci_application_profile.ap_profile[each.key].id
#   name                   = each.value.name
# }

# Get the VMM Domain data
data "aci_vmm_domain" "vmm_domain" {
  provider_profile_dn = "uni/vmmp-${var.vmm_provider}"
  name                = var.vmm_name
}
