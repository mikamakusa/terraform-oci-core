## APP CATALOG LISTING RESOURCE VERSION AGREEMENT

output "app_catalog_listing_resource_version_agreement_id" {
  value = try(
    oci_core_app_catalog_listing_resource_version_agreement.this.*.id
  )
}

output "app_catalog_listing_resource_version_agreement_listing_id" {
  value = try(
    oci_core_app_catalog_listing_resource_version_agreement.this.*.listing_id
  )
}

## APP CATALOG SUBSCRIPTION

output "app_catalog_subscription_id" {
  value = try(
    oci_core_app_catalog_subscription.this.*.id
  )
}

output "app_catalog_subscription_listing_id" {
  value = try(
    oci_core_app_catalog_subscription.this.*.listing_id
  )
}

output "app_catalog_subscription_compartment_id" {
  value = try(
    oci_core_app_catalog_subscription.this.*.compartment_id
  )
}

output "app_catalog_subscription_eula_link" {
  value = try(
    oci_core_app_catalog_subscription.this.*.eula_link
  )
}

## BOOT VOLUME

output "boot_volume_id" {
  value = try(
    oci_core_boot_volume.this.*.id
  )
}

output "boot_volume_state" {
  value = try(
    oci_core_boot_volume.this.*.state
  )
}

## BOOT VOLUME BACKUP

output "boot_volume_backup_id" {
  value = try(
    oci_core_boot_volume_backup.this.*.id
  )
}

## CAPTURE FILTER

output "capture_filter_id" {
  value = try(
    oci_core_capture_filter.this.*.id
  )
}

output "capture_filter_compartment_id" {
  value = try(
    oci_core_capture_filter.this.*.compartment_id
  )
}

output "capture_filter_state" {
  value = try(
    oci_core_capture_filter.this.*.state
  )
}

## CLUSTER NETWORK

output "cluster_network_id" {
  value = try(
    oci_core_cluster_network.this.*.id
  )
}

output "cluster_network_state" {
  value = try(
    oci_core_cluster_network.this.*.state
  )
}

## COMPUTE CAPACITY REPORT

output "compute_capacity_report_id" {
  value = try(
    oci_core_compute_capacity_report.this.*.id
  )
}

output "compute_capacity_report_availability_domain" {
  value = try(
    oci_core_compute_capacity_report.this.*.availability_domain
  )
}

## COMPUTE CAPACITY RESERVATION

output "compute_capacity_reservation_id" {
  value = try(
    oci_core_compute_capacity_reservation.this.*.id
  )
}

output "compute_capacity_reservation_display_name" {
  value = try(
    oci_core_compute_capacity_reservation.this.*.display_name
  )
}

output "compute_capacity_reservation_state" {
  value = try(
    oci_core_compute_capacity_reservation.this.*.state
  )
}

## COMPUTE CAPACITY TOPOLOGY

output "compute_capacity_topology_id" {
  value = try(
    oci_core_compute_capacity_topology.this.*.id
  )
}

output "compute_capacity_topology_display_name" {
  value = try(
    oci_core_compute_capacity_topology.this.*.display_name
  )
}

output "compute_capacity_topology_state" {
  value = try(
    oci_core_compute_capacity_topology.this.*.state
  )
}

## COMPUTE CLUSTER

output "compute_cluster_id" {
  value = try(
    oci_core_compute_cluster.this.*.id
  )
}

output "compute_cluster_state" {
  value = try(
    oci_core_compute_cluster.this.*.state
  )
}

## COMPUTE IMAGE CAPABILITY SCHEMA

output "compute_image_capability_schema_id" {
  value = try(
    oci_core_compute_image_capability_schema.this.*.id
  )
}

output "compute_image_capability_schema_display_name" {
  value = try(
    oci_core_compute_image_capability_schema.this.*.display_name
  )
}

## CONSOLE HISTORY

output "console_history_id" {
  value = try(
    oci_core_console_history.this.*.id
  )
}

output "console_history_display_name" {
  value = try(
    oci_core_console_history.this.*.display_name
  )
}

output "console_history_state" {
  value = try(
    oci_core_console_history.this.*.state
  )
}

## CPE

output "cpe_id" {
  value = try(
    oci_core_cpe.this.*.id
  )
}

output "cpe_device_shape_id" {
  value = try(
    oci_core_cpe.this.*.cpe_device_shape_id
  )
}

output "cpe_display_name" {
  value = try(
    oci_core_cpe.this.*.display_name
  )
}

output "cpe_is_private" {
  value = try(
    oci_core_cpe.this.*.is_private
  )
}

## CROSS CONNECT

output "cross_connect_id" {
  value = try(
    oci_core_cross_connect.this.*.id
  )
}

output "cross_connect_state" {
  value = try(
    oci_core_cross_connect.this.*.state
  )
}

## CROSS CONNECT GROUP

output "cross_connect_group_id" {
  value = try(
    oci_core_cross_connect_group.this.*.id
  )
}

## DEDICATED VM HOST

output "dedicated_vm_host_id" {
  value = try(
    oci_core_dedicated_vm_host.this.*.id
  )
}

output "dedicated_vm_host_state" {
  value = try(
    oci_core_dedicated_vm_host.this.*.state
  )
}

## DRG

output "drg_id" {
  value = try(
    oci_core_drg.this.*.id
  )
}

output "drg_default_drg_route_tables" {
  value = try(
    oci_core_drg.this.*.default_drg_route_tables
  )
}

output "drg_default_export_drg_route_distribution_id" {
  value = try(
    oci_core_drg.this.*.default_export_drg_route_distribution_id
  )
}

output "drg_redundancy_status" {
  value = try(
    oci_core_drg.this.*.redundancy_status
  )
}

## DRG ATTACHMENT

output "drg_attachment_id" {
  value = try(
    oci_core_drg_attachment.this.*.id
  )
}

output "drg_attachment_state" {
  value = try(
    oci_core_drg_attachment.this.*.state
  )
}

output "drg_attachment_route_table_id" {
  value = try(
    oci_core_drg_attachment.this.*.route_table_id
  )
}

output "drg_attachment_is_cross_tenancy" {
  value = try(
    oci_core_drg_attachment.this.*.is_cross_tenancy
  )
}

output "drg_attachment_export_drg_route_distribution_id" {
  value = try(
    oci_core_drg_attachment.this.*.export_drg_route_distribution_id
  )
}

## DRG ATTACHMENT MANAGEMENT

output "drg_attachment_management_id" {
  value = try(
    oci_core_drg_attachment_management.this.*.id
  )
}

output "drg_attachment_management_is_cross_tenancy" {
  value = try(
    oci_core_drg_attachment_management.this.*.is_cross_tenancy
  )
}

output "drg_attachment_management_export_drg_route_distribution_id" {
  value = try(
    oci_core_drg_attachment_management.this.*.export_drg_route_distribution_id
  )
}

output "drg_attachment_management_route_table_id" {
  value = try(
    oci_core_drg_attachment_management.this.*.route_table_id
  )
}

## DRG ATTACHMENT LIST

output "drg_attachment_list_id" {
  value = try(
    oci_core_drg_attachments_list.this.*.id
  )
}

output "drg_all_attachments" {
  value = try(
    oci_core_drg_attachments_list.this.*.drg_all_attachments
  )
}

## DRG ROUTE DISTRIBUTION

output "drg_route_distribution_id" {
  value = try(
    oci_core_drg_route_distribution.this.*.id
  )
}

## DRG ROUTE DISTRIBUTION STATEMENT

output "drg_route_distribution_statement_id" {
  value = try(
    oci_core_drg_route_distribution_statement.this.*.id
  )
}

output "drg_route_distribution_statement_route_distribution_id" {
  value = try(
    oci_core_drg_route_distribution_statement.this.*.drg_route_distribution_id
  )
}

output "drg_route_distribution_statement_priority" {
  value = try(
    oci_core_drg_route_distribution_statement.this.*.priority
  )
}

## DRG ROUTE TABLE

output "drg_route_table_id" {
  value = try(
    oci_core_drg_route_table.this.*.id
  )
}

output "drg_route_table_state" {
  value = try(
    oci_core_drg_route_table.this.*.state
  )
}

output "drg_route_table_import_drg_route_distribution_id" {
  value = try(
    oci_core_drg_route_table.this.*.import_drg_route_distribution_id
  )
}

## DRG ROUTE TABLE ROUTE RULE

output "drg_route_table_route_rule_id" {
  value = try(
    oci_core_drg_route_table_route_rule.this.*.id
  )
}

output "drg_route_table_route_rule_destination" {
  value = try(
    oci_core_drg_route_table_route_rule.this.*.destination
  )
}

output "drg_route_table_route_rule_destination_type" {
  value = try(
    oci_core_drg_route_table_route_rule.this.*.destination_type
  )
}

## IMAGE

output "image_id" {
  value = try(
    oci_core_image.this.*.id
  )
}

output "image_launch_mode" {
  value = try(
    oci_core_image.this.*.launch_mode
  )
}

output "image_instance_id" {
  value = try(
    oci_core_image.this.*.instance_id
  )
}

## INSTANCE

output "instance_id" {
  value = try(
    oci_core_instance.this.*.id
  )
}

## INSTANCE CONSOLE CONNECTION

output "instance_console_connection_id" {
  value = try(
    oci_core_instance_console_connection.this.*.id
  )
}

output "instance_console_connection_state" {
  value = try(
    oci_core_instance_console_connection.this.*.state
  )
}

## INSTANCE CONFIGURATION

output "instance_configuration_id" {
  value = try(
    oci_core_instance_configuration.this.*.id
  )
}

output "instance_configuration_display_name" {
  value = try(
    oci_core_instance_configuration.this.*.display_name
  )
}

## INSTANCE POOL

output "instance_pool_id" {
  value = try(
    oci_core_instance_pool.this.*.id
  )
}

output "instance_pool_display_name" {
  value = try(
    oci_core_instance_pool.this.*.display_name
  )
}

output "instance_pool_configuration_id" {
  value = try(
    oci_core_instance_pool.this.*.instance_configuration_id
  )
}

## INSTANCE POOL INSTANCE

output "instance_pool_instance_id" {
  value = try(
    oci_core_instance_pool_instance.this.*.id
  )
}

## INTERNET GATEWAY

output "internet_gateway_id" {
  value = try(
    oci_core_internet_gateway.this.*.id
  )
}

## IPSEC

output "ipsec_id" {
  value = try(
    oci_core_ipsec.this.*.id
  )
}

## IPSEC CONNECTION TUNNEL MANAGEMENT

output "ipsec_connection_tunnel_management_id" {
  value = try(
    oci_core_ipsec_connection_tunnel_management.this.*.id
  )
}

output "ipsec_connection_tunnel_management_state" {
  value = try(
    oci_core_ipsec_connection_tunnel_management.this.*.state
  )
}

output "ipsec_connection_tunnel_management_vpn_ip" {
  value = try(
    oci_core_ipsec_connection_tunnel_management.this.*.vpn_ip
  )
}

output "ipsec_connection_tunnel_management_nat_translation_enabled" {
  value = try(
    oci_core_ipsec_connection_tunnel_management.this.*.nat_translation_enabled
  )
}

## IPV6

output "ipv6_id" {
  value = try(
    oci_core_ipv6.this.*.id
  )
}

output "ipv6_state" {
  value = try(
    oci_core_ipv6.this.*.state
  )
}

output "ipv6_vnic_id" {
  value = try(
    oci_core_ipv6.this.*.vnic_id
  )
}

output "ipv6_ip_address" {
  value = try(
    oci_core_ipv6.this.*.ip_address
  )
}

## LOCAL PEERING GATEWAY

output "local_peering_gateway_id" {
  value = try(
    oci_core_local_peering_gateway.this.*.id
  )
}

## NAT GATEWAY

output "nat_gateway_id" {
  value = try(
    oci_core_nat_gateway.this.*.id
  )
}

## NETWORK SECURITY GROUP && RULE

output "network_security_group_id" {
  value = try(
    join(":", [oci_core_network_security_group.this.*.id, oci_core_network_security_group.this.*.display_name])
  )
}

output "network_security_group_security_rule_id" {
  value = try(
    oci_core_network_security_group_security_rule.this.*.id
  )
}

## PRIVATE IP

output "private_ip_id_ip_address" {
  value = try(
    join(":", [oci_core_private_ip.this.*.id, oci_core_private_ip.this.*.ip_address])
  )
}

## PUBLIC IP

output "public_ip_id_ip_address" {
  value = try(
    join(":", [oci_core_public_ip.this.*.id, oci_core_public_ip.this.*.ip_address])
  )
}

## PUBLIC IP POOL

output "public_ip_pool_id" {
  value = try(
    oci_core_public_ip_pool.this.*.id
  )
}

output "public_ip_pool_display_name" {
  value = try(
    oci_core_public_ip_pool.this.*.display_name
  )
}

## REMOTE PEERING CONNECTION

output "remote_peering_connection_id" {
  value = try(
    oci_core_remote_peering_connection.this.*.id
  )
}

output "remote_peering_connection_display_name" {
  value = try(
    oci_core_remote_peering_connection.this.*.display_name
  )
}

## ROUTE TABLE

output "route_table_id" {
  value = try(
    oci_core_route_table.this.*.id
  )
}

output "route_table_display_name" {
  value = try(
    oci_core_route_table.this.*.display_name
  )
}

## ROUTE TABLE ATTACHMENT

output "route_table_attachment_id" {
  value = try(
    oci_core_route_table_attachment.this.*.id
  )
}

output "route_table_attachment_to_route_table_id" {
  value = try(
    oci_core_route_table_attachment.this.*.route_table_id
  )
}

## SECURITY LIST

output "security_list_id" {
  value = try(
    oci_core_security_list.this.*.id
  )
}

output "security_list_display_name" {
  value = try(
    oci_core_security_list.this.*.display_name
  )
}

## SERVICE GATEWAY

output "service_gateway_id" {
  value = try(
    oci_core_service_gateway.this.*.id
  )
}

output "service_gateway_display_name" {
  value = try(
    oci_core_service_gateway.this.*.display_name
  )
}

## SHAPE MANAGEMENT

output "shape_management_id" {
  value = try(
    oci_core_shape_management.this.*.id
  )
}

## SUBNET

output "subnet_id" {
  value = try(
    oci_core_subnet.this.*.id
  )
}

output "subnet_display_name" {
  value = try(
    oci_core_subnet.this.*.display_name
  )
}

## VCN

output "vcn_id" {
  value = try(
    oci_core_vcn.this.*.id
  )
}

output "vcn_display_name" {
  value = try(
    oci_core_vcn.this.*.display_name
  )
}

## VIRTUAL CIRCUIT

output "virtual_circuit_id" {
  value = try(
    oci_core_virtual_circuit.name.*.id
  )
}

output "virtual_circuit_display_name" {
  value = try(
    oci_core_virtual_circuit.name.*.display_name
  )
}

## VLAN

output "vlan_id" {
  value = try(
    oci_core_vlan.this.*.id
  )
}

output "vlan_display_name" {
  value = try(
    oci_core_vlan.this.*.display_name
  )
}

output "vlan_state" {
  value = try(
    oci_core_vlan.this.*.state
  )
}

output "vlan_route_table_id" {
  value = try(
    oci_core_vlan.this.*.route_table_id
  )
}

output "vlan_cidr_block" {
  value = try(
    oci_core_vlan.this.*.cidr_block
  )
}

output "vlan_tag" {
  value = try(
    oci_core_vlan.this.*.vlan_tag
  )
}

## VNIC ATTACHMENT

output "vnic_attachment_id" {
  value = try(
    oci_core_vnic_attachment.this.*.id
  )
}

## VOLUME

output "volume_id" {
  value = try(
    oci_core_volume.this.*.id
  )
}

output "volume_display_name" {
  value = try(
    oci_core_volume.this.*.display_name
  )
}

## VOLUME ATTACHMENT

output "volume_attachment_id" {
  value = try(
    oci_core_volume_attachment.this.*.id
  )
}

output "volume_attachment_display_name" {
  value = try(
    oci_core_volume_attachment.this.*.display_name
  )
}

## VOLUME BACKUP

output "volume_backup_id" {
  value = try(
    oci_core_volume_backup.this.*.id
  )
}

output "volume_backup_display_name" {
  value = try(
    oci_core_volume_backup.this.*.display_name
  )
}

## VOLUME BACKUP POLICY

output "volume_backup_policy_id" {
  value = try(
    oci_core_volume_backup_policy.this.*.id
  )
}

output "volume_backup_policy_display_name" {
  value = try(
    oci_core_volume_backup_policy.this.*.display_name
  )
}

## VOLUME BACKUP POLICY ASSIGNMENT

output "volume_backup_policy_assignment_id" {
  value = try(
    oci_core_volume_backup_policy_assignment.this.*.id
  )
}

## VOLUME GROUP

output "volume_group_id" {
  value = try(
    oci_core_volume_group.this.*.id
  )
}

output "volume_group_display_name" {
  value = try(
    oci_core_volume_group.this.*.display_name
  )
}

## VOLUME GROUP BACKUP

output "volume_group_backup_id" {
  value = try(
    oci_core_volume_group_backup.this.*.id
  )
}

output "volume_group_backup_display_name" {
  value = try(
    oci_core_volume_group_backup.this.*.display_name
  )
}

## VTAP

output "vtap_id" {
  value       = try(
    oci_core_vtap.this.*.id
  )
}

output "vtap_display_name" {
  value       = try(
    oci_core_vtap.this.*.display_name
  )
}