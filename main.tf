#===============================================================================
# ACI Resources
#===============================================================================

module "demo_base" {
  source = "./modules/demo_base/"

  aci_tn  = var.aci_tn
  aci_vrf = var.aci_vrf
  aci_bds = var.aci_bds
  epgs    = var.epgs
}

module "vmm_domain" {
  source = "./modules/vmm_domain"
  epgs         = module.demo_base.aci_application_epg_out
  tdn          = data.aci_vmm_domain.vmm_domain.id
  vmm_provider = var.vmm_provider
}

module "filters" {
  source    = "./modules/policy/filters/"
  tenant_dn = module.demo_base.aci_tenant_out
}
