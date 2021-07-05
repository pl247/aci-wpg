#========================================#
#  ACI Authentications Parameters        #
#========================================#

variable "apic" {
  type = object({
    user           = string
    password       = string
    url            = string
    unverified_ssl = bool
  })
  default = {
    user           = ""
    password       = ""
    url            = ""
    unverified_ssl = true
  }
}

#========================================#
#  ACI Demo Configurations               #
#========================================#

variable "vmm_provider" {
  description = "Definition of vmm provider options are 'VMware, Microsoft, etc'"
  type        = string
  default     = "VMware"
}

variable "vmm_name" {
  description = "VMM Domain Integration Name"
  type = string
}

variable "aci_tn" {
  type = object({
    name        = string
    description = string
  })
  default = {
    name        = "ACME_tf"
    description = "ACME Tenant Created with Terraform"
  }
}

variable "aci_vrf" {
  description = "Define the vrf to be created in the tenant"
  type        = string
  default     = "internal"
}

variable "aci_bds" {
  /*
    When creating object names use the same as the defined name this 
    will simplify references from epgs variables. If using ip addresses ensure enclosed
    in quotes to support the decimal.
    */
  type = map(object({
    name        = string
    description = string
    subnet      = string
  }))
  default = {
    "192.168.0.0_24" = {
      name        = "192.168.0.0_24"
      description = "Default Bridge Domain"
      subnet      = "192.168.0.100/24"
    }
  }
}

variable "epgs" {
  type = map(object({
    ap_profile    = string
    name          = string
    bridge_domain = string
  }))
  default = {
    app_epg = {
      ap_profile    = "demo_ap"
      name          = "app_epg"
      bridge_domain = "192.168.0.0_24"
    }
  }
}
