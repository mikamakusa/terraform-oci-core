module "identity" {
  source      = "./modules/terraform-oci-identity"
  compartment = var.compartment
}

module "kms" {
  source      = "./modules/terraform-oci-kms"
  compartment = var.compartment
  subnet      = var.subnet
}