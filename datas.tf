data "oci_core_cpe_device_shapes" "this" {}

data "oci_core_ipsec_connection_tunnels" "this" {
  count    = length(var.ipsec) == 0 ? 0 : length(var.ipsec_connection_tunnels)
  ipsec_id = try(element(oci_core_ipsec.this.*.id, lookup(var.ipsec_connection_tunnels[count.index], "ipsec_id")))
}

data "oci_core_ipsec_connection_tunnel" "this" {
  count     = (length(var.ipsec) && length(var.ipsec_connection_tunnels)) == 0 ? 0 : length(var.ipsec_connection_tunnel)
  ipsec_id  = try(element(oci_core_ipsec.this.*.id, lookup(var.ipsec_connection_tunnel[count.index], "ipsec_id")))
  tunnel_id = try(element(data.oci_core_ipsec_connection_tunnels.this.*.ip_sec_connection_tunnels[0].id, lookup(var.ipsec_connection_tunnel[count.index], "tunnel_id")))
}

data "oci_core_services" "this" {}

data "oci_core_fast_connect_provider_services" "this" {
  count          = length(var.compartment) == 0 ? 0 : length(var.fast_connect_provider_services)
  compartment_id = try(element(module.identity.*.compartment_id, lookup(var.fast_connect_provider_services[count.index], "compartment_id")))
}

data "oci_core_fast_connect_provider_service" "this" {
  count               = length(var.fast_connect_provider_services) == 0 ? 0 : length(var.fast_connect_provider_service)
  provider_service_id = try(element(data.oci_core_fast_connect_provider_services.this.*.fast_connect_provider_services.0.id, lookup(var.fast_connect_provider_service[count.index], "provider_service_id")))
}