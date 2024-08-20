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