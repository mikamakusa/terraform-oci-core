module "identity" {
  source      = "modules/terraform-oci-identity"
  compartment = var.compartment
}