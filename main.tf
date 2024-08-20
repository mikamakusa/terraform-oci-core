resource "oci_core_app_catalog_listing_resource_version_agreement" "this" {
  count                    = length(var.app_catalog_listing_resource_version_agreement)
  listing_id               = element(oci_core_app_catalog_listing_resource_version_agreement.this.*.listing_id, lookup(var.app_catalog_listing_resource_version_agreement[count.index], "listing_id"))
  listing_resource_version = lookup(var.app_catalog_listing_resource_version_agreement[count.index], "listing_resource_version")
}

resource "oci_core_app_catalog_subscription" "this" {
  count                    = (length(var.app_catalog_listing_resource_version_agreement) && length(var.compartment)) == 0 ? 0 : length(var.app_catalog_subscription)
  compartment_id           = try(element(module.identity.*.compartment_id, lookup(var.app_catalog_subscription[count.index], "compartment_id")))
  listing_id               = try(element(oci_core_app_catalog_listing_resource_version_agreement.this.*.listing_id, lookup(var.app_catalog_subscription[count.index], "listing_id")))
  listing_resource_version = lookup(var.app_catalog_subscription[count.index], "listing_resource_version")
  oracle_terms_of_use_link = lookup(var.app_catalog_subscription[count.index], "oracle_terms_of_use_link")
  signature                = lookup(var.app_catalog_subscription[count.index], "signature")
  time_retrieved           = lookup(var.app_catalog_subscription[count.index], "time_retrieved")
  eula_link                = lookup(var.app_catalog_subscription[count.index], "eula_link")
}

resource "oci_core_boot_volume" "this" {
  count                      = length(var.compartment) == 0 ? 0 : length(var.boot_volume)
  availability_domain        = lookup(var.boot_volume[count.index], "availability_domain")
  compartment_id             = try(element(module.identity.*.compartment_id, lookup(var.boot_volume[count.index], "compartment_id")))
  cluster_placement_group_id = try(element(module.identity.*.group_id, lookup(var.boot_volume[count.index], "cluster_placement_group_id")))
  defined_tags               = merge(var.defined_tags, lookup(var.boot_volume[count.index], "defined_tags"))
  display_name               = lookup(var.boot_volume[count.index], "display_name")
  freeform_tags              = merge(var.freeform_tags, lookup(var.boot_volume[count.index], "freeform_tags"))
  is_auto_tune_enabled       = lookup(var.boot_volume[count.index], "is_auto_tune_enabled")
  #kms_key_id                    = ""
  size_in_gbs                   = lookup(var.boot_volume[count.index], "size_in_gbs")
  vpus_per_gb                   = lookup(var.boot_volume[count.index], "vpus_per_gb")
  boot_volume_replicas_deletion = lookup(var.boot_volume[count.index], "boot_volume_replicas_deletion")

  dynamic "source_details" {
    for_each = lookup(var.boot_volume[count.index], "source_details")
    content {
      type = lookup(source_details.value, "type")
      id   = lookup(source_details.value, "id")
    }
  }

  dynamic "autotune_policies" {
    for_each = try(lookup(var.boot_volume[count.index], "autotune_policies") == null ? [] : ["autotune_policies"])
    content {
      autotune_type   = lookup(autotune_policies.value, "autotune_type")
      max_vpus_per_gb = lookup(autotune_policies.value, "max_vpus_per_gb")
    }
  }

  dynamic "boot_volume_replicas" {
    for_each = try(lookup(var.boot_volume[count.index], "boot_volume_replicas") == null ? [] : ["boot_volume_replicas"])
    content {
      availability_domain = lookup(boot_volume_replicas.value, "availability_domain")
      display_name        = lookup(boot_volume_replicas.value, "display_name")
    }
  }
}

resource "oci_core_boot_volume_backup" "this" {
  count          = length(var.boot_volume) == 0 ? 0 : length(var.boot_volume_backup)
  boot_volume_id = try(element(oci_core_boot_volume.this.*.id, lookup(var.boot_volume_backup[count.index], "boot_volume_id")))
  defined_tags   = merge(var.defined_tags, lookup(var.boot_volume_backup[count.index], "defined_tags"))
  display_name   = lookup(var.boot_volume_backup[count.index], "display_name")
  freeform_tags  = merge(var.freeform_tags, lookup(var.boot_volume_backup[count.index], "freeform_tags"))
  #kms_key_id     = ""
  type = lookup(var.boot_volume_backup[count.index], "type")

  dynamic "source_details" {
    for_each = lookup(var.boot_volume_backup[count.index], "boot_volume_id") != null ? [] : lookup(var.boot_volume_backup[count.index], "source_details")
    content {
      boot_volume_backup_id = try(element(oci_core_boot_volume.this.*.id, lookup(source_details.value, "boot_volume_id")))
      region                = lookup(source_details.value, "region")
      #kms_key_id            = ""
    }
  }
}

resource "oci_core_capture_filter" "this" {
  count          = length(var.compartment) == 0 ? 0 : length(var.capture_filter)
  compartment_id = try(element(module.identity.*.compartment_id, lookup(var.capture_filter[count.index], "compartment_id")))
  filter_type    = lookup(var.capture_filter[count.index], "filter_type")
  defined_tags   = merge(var.defined_tags, lookup(var.capture_filter[count.index], "defined_tags"))
  display_name   = lookup(var.capture_filter[count.index], "display_name")
  freeform_tags  = merge(var.freeform_tags, lookup(var.capture_filter[count.index], "freeform_tags"))

  dynamic "flow_log_capture_filter_rules" {
    for_each = try(lookup(var.capture_filter[count.index], "flow_log_capture_filter_rules") == null ? [] : ["flow_log_capture_filter_rules"])
    content {
      destination_cidr = lookup(flow_log_capture_filter_rules.value, "destination_cidr")
      flow_log_type    = lookup(flow_log_capture_filter_rules.value, "flow_log_type")
      is_enabled       = lookup(flow_log_capture_filter_rules.value, "is_enabled")
      priority         = lookup(flow_log_capture_filter_rules.value, "priority")
      protocol         = lookup(flow_log_capture_filter_rules.value, "protocol")
      rule_action      = lookup(flow_log_capture_filter_rules.value, "rule_action")
      sampling_rate    = lookup(flow_log_capture_filter_rules.value, "sampling_rate")
      source_cidr      = lookup(flow_log_capture_filter_rules.value, "source_cidr")

      dynamic "icmp_options" {
        for_each = try(lookup(flow_log_capture_filter_rules.value, "icmp_options") == null ? [] : ["icmp_options"])
        content {
          type = lookup(icmp_options.value, "type")
          code = lookup(icmp_options.value, "code")
        }
      }

      dynamic "tcp_options" {
        for_each = try(lookup(flow_log_capture_filter_rules.value, "tcp_options") == null ? [] : ["tcp_options"])
        content {
          dynamic "destination_port_range" {
            for_each = try(lookup(tcp_options.value, "destination_port_range") == null ? [] : ["destination_port_range"])
            content {
              max = lookup(destination_port_range.value, "max")
              min = lookup(destination_port_range.value, "min")
            }
          }

          dynamic "source_port_range" {
            for_each = try(lookup(tcp_options.value, "source_port_range") == null ? [] : ["source_port_range"])
            content {
              max = lookup(source_port_range.value, "max")
              min = lookup(source_port_range.value, "min")
            }
          }
        }
      }

      dynamic "udp_options" {
        for_each = try(lookup(flow_log_capture_filter_rules.value, "udp_options") == null ? [] : ["udp_options"])
        content {
          dynamic "destination_port_range" {
            for_each = try(lookup(udp_options.value, "destination_port_range") == null ? [] : ["destination_port_range"])
            content {
              max = lookup(destination_port_range.value, "max")
              min = lookup(destination_port_range.value, "min")
            }
          }

          dynamic "source_port_range" {
            for_each = try(lookup(udp_options.value, "source_port_range") == null ? [] : ["source_port_range"])
            content {
              max = lookup(source_port_range.value, "max")
              min = lookup(source_port_range.value, "min")
            }
          }
        }
      }
    }
  }

  dynamic "vtap_capture_filter_rules" {
    for_each = try(lookup(var.capture_filter[count.index], "vtap_capture_filter_rules") == null ? [] : ["vtap_capture_filter_rules"])
    content {
      traffic_direction = lookup(vtap_capture_filter_rules.value, "traffic_direction")
      destination_cidr  = lookup(vtap_capture_filter_rules.value, "destination_cidr")
      protocol          = lookup(vtap_capture_filter_rules.value, "protocol")
      rule_action       = lookup(vtap_capture_filter_rules.value, "rule_action")
      source_cidr       = lookup(vtap_capture_filter_rules.value, "source_cidr")

      dynamic "icmp_options" {
        for_each = try(lookup(vtap_capture_filter_rules.value, "icmp_options") == null ? [] : ["icmp_options"])
        content {
          type = lookup(icmp_options.value, "type")
          code = lookup(icmp_options.value, "code")
        }
      }

      dynamic "tcp_options" {
        for_each = try(lookup(vtap_capture_filter_rules.value, "tcp_options") == null ? [] : ["tcp_options"])
        content {
          dynamic "destination_port_range" {
            for_each = try(lookup(tcp_options.value, "destination_port_range") == null ? [] : ["destination_port_range"])
            content {
              max = lookup(destination_port_range.value, "max")
              min = lookup(destination_port_range.value, "min")
            }
          }

          dynamic "source_port_range" {
            for_each = try(lookup(tcp_options.value, "source_port_range") == null ? [] : ["source_port_range"])
            content {
              max = lookup(source_port_range.value, "max")
              min = lookup(source_port_range.value, "min")
            }
          }
        }
      }

      dynamic "udp_options" {
        for_each = try(lookup(vtap_capture_filter_rules.value, "udp_options") == null ? [] : ["udp_options"])
        content {
          dynamic "destination_port_range" {
            for_each = try(lookup(udp_options.value, "destination_port_range") == null ? [] : ["destination_port_range"])
            content {
              max = lookup(destination_port_range.value, "max")
              min = lookup(destination_port_range.value, "min")
            }
          }

          dynamic "source_port_range" {
            for_each = try(lookup(udp_options.value, "source_port_range") == null ? [] : ["source_port_range"])
            content {
              max = lookup(source_port_range.value, "max")
              min = lookup(source_port_range.value, "min")
            }
          }
        }
      }
    }
  }
}

resource "oci_core_cluster_network" "this" {
  count          = length(var.compartment) == 0 ? 0 : length(var.cluster_network)
  compartment_id = try(element(module.identity.*.compartment_id, lookup(var.cluster_network[count.index], "compartment_id")))
  defined_tags   = merge(var.defined_tags, lookup(var.cluster_network[count.index], "defined_tags"))
  display_name   = lookup(var.cluster_network[count.index], "display_name")
  freeform_tags  = merge(var.freeform_tags, lookup(var.cluster_network[count.index], "freeform_tags"))

  dynamic "instance_pools" {
    for_each = lookup(var.cluster_network[count.index], "instance_pools")
    content {
      instance_configuration_id = ""
      size                      = lookup(instance_pools.value, "size")
      defined_tags              = merge(var.defined_tags, lookup(instance_pools.value, "defined_tags"))
      freeform_tags             = merge(var.freeform_tags, lookup(instance_pools.value, "freeform_tags"))
      display_name              = lookup(instance_pools.value, "display_name")
    }
  }

  dynamic "placement_configuration" {
    for_each = lookup(var.cluster_network[count.index], "placement_configuration")
    iterator = placement
    content {
      availability_domain = lookup(placement.value, "availability_domain")
      primary_subnet_id   = try(element(oci_core_subnet.this.*.id, lookup(placement.value, "primary_subnet_id")))

      dynamic "primary_vnic_subnets" {
        for_each = try(lookup(placement.value, "primary_vnic_subnets") == null ? [] : ["primary_vnic_subnets"])
        content {
          subnet_id        = element(oci_core_subnet.this.*.id, lookup(primary_vnic_subnets.value, "subnet_id"))
          is_assign_ipv6ip = lookup(primary_vnic_subnets.value, "is_assign_ipv6ip")

          dynamic "ipv6address_ipv6subnet_cidr_pair_details" {
            for_each = try(lookup(primary_vnic_subnets.value, "ipv6address_ipv6subnet_cidr_pair_details") == null ? [] : ["ipv6address_ipv6subnet_cidr_pair_details"])
            iterator = details
            content {
              ipv6subnet_cidr = lookup(details.value, "ipv6subnet_cidr")
            }
          }
        }
      }

      dynamic "secondary_vnic_subnets" {
        for_each = try(lookup(placement.value, "secondary_vnic_subnets") == null ? [] : ["secondary_vnic_subnets"])
        content {
          subnet_id        = element(oci_core_subnet.this.*.id, lookup(secondary_vnic_subnets.value, "subnet_id"))
          is_assign_ipv6ip = lookup(secondary_vnic_subnets.value, "is_assign_ipv6ip")

          dynamic "ipv6address_ipv6subnet_cidr_pair_details" {
            for_each = try(lookup(secondary_vnic_subnets.value, "ipv6address_ipv6subnet_cidr_pair_details") == null ? [] : ["ipv6address_ipv6subnet_cidr_pair_details"])
            iterator = details
            content {
              ipv6subnet_cidr = lookup(details.value, "ipv6subnet_cidr")
            }
          }
        }
      }
    }
  }

  /* dynamic "cluster_configuration" {
    for_each = try(lookup(var.cluster_network[count.index], "cluster_configuration") == null ? [] : ["cluster_configuration"])
    iterator = cluster
    content {
      hpc_island_id     = ""
      network_block_ids = lookup(cluster.value, "network_block_ids")
    }
  } */
}

resource "oci_core_compute_capacity_report" "this" {
  count               = length(var.compartment) == 0 ? 0 : length(var.compute_capacity_report)
  availability_domain = lookup(var.compute_capacity_report[count.index], "availability_domain")
  compartment_id      = try(element(module.identity.*.compartment_id, lookup(var.compute_capacity_report[count.index], "compartment_id")))

  dynamic "shape_availabilities" {
    for_each = lookup(var.compute_capacity_report[count.index], "shape_availabilities")
    iterator = shape
    content {
      instance_shape = lookup(shape.value, "instance_shape")
      fault_domain   = lookup(shape.value, "fault_domain")

      dynamic "instance_shape_config" {
        for_each = try(lookup(shape.value, "instance_shape_config") == null ? [] : ["instance_shape_config"])
        iterator = config
        content {
          memory_in_gbs = lookup(config.value, "memory_in_gbs")
          nvmes         = lookup(config.value, "nvmes")
          ocpus         = lookup(config.value, "ocpus")
        }
      }
    }
  }
}

resource "oci_core_compute_capacity_reservation" "this" {
  count                  = length(var.compartment) == 0 ? 0 : length(var.compute_capacity_reservation)
  availability_domain    = lookup(var.compute_capacity_reservation[count.index], "availability_domain")
  compartment_id         = try(element(module.identity.*.compartment_id, lookup(var.compute_capacity_reservation[count.index], "compartment_id")))
  defined_tags           = merge(var.defined_tags, lookup(var.compute_capacity_reservation[count.index], "defined_tags"))
  display_name           = lookup(var.compute_capacity_reservation[count.index], "display_name")
  freeform_tags          = merge(var.freeform_tags, lookup(var.compute_capacity_reservation[count.index], "freeform_tags"))
  is_default_reservation = lookup(var.compute_capacity_reservation[count.index], "is_default_reservation")

  dynamic "instance_reservation_configs" {
    iterator = instance
    for_each = lookup(var.compute_capacity_reservation[count.index], "instance_reservation_configs")
    content {
      reserved_count             = lookup(instance.value, "reserved_count")
      instance_shape             = lookup(instance.value, "instance_shape")
      cluster_placement_group_id = try(element(module.identity.*.group_id, lookup(instance.value, "cluster_placement_group_id")))
      fault_domain               = lookup(instance.value, "fault_domain")

      dynamic "cluster_config" {
        iterator = cluster
        for_each = try(lookup(instance.value, "cluster_config") == null ? [] : ["cluster_config"])
        content {
          hpc_island_id     = ""
          network_block_ids = lookup(cluster.value, "network_block_ids")
        }
      }

      dynamic "instance_shape_config" {
        iterator = config
        for_each = try(lookup(instance.value, "instance_shape_config") == null ? [] : ["instance_shape_config"])
        content {
          memory_in_gbs = lookup(config.value, "memory_in_gbs")
          ocpus         = lookup(config.value, "ocpus")
        }
      }
    }
  }
}

resource "oci_core_compute_capacity_topology" "this" {
  count               = length(var.compartment) == 0 ? 0 : length(var.compute_capacity_topology)
  availability_domain = lookup(var.compute_capacity_topology[count.index], "availability_domain")
  compartment_id      = try(element(module.identity.*.compartment_id, lookup(var.compute_capacity_topology[count.index], "compartment_id")))
  display_name        = lookup(var.compute_capacity_topology[count.index], "display_name")
  defined_tags        = merge(var.defined_tags, lookup(var.compute_capacity_reservation[count.index], "defined_tags"))
  freeform_tags       = merge(var.freeform_tags, lookup(var.compute_capacity_reservation[count.index], "freeform_tags"))

  dynamic "capacity_source" {
    for_each = lookup(var.compute_capacity_topology[count.index], "capacity_source")
    iterator = source
    content {
      capacity_type  = lookup(source.value, "capacity_type")
      compartment_id = try(element(module.identity.*.compartment_id, lookup(source.value, "compartment_id")))
    }
  }
}

resource "oci_core_compute_cluster" "this" {
  count               = length(var.compartment) == 0 ? 0 : length(var.compute_cluster)
  availability_domain = lookup(var.compute_cluster[count.index], "availability_domain")
  compartment_id      = try(element(module.identity.*.compartment_id, lookup(var.compute_cluster[count.index], "compartment_id")))
  display_name        = lookup(var.compute_cluster[count.index], "display_name")
  defined_tags        = merge(var.defined_tags, lookup(var.compute_cluster[count.index], "defined_tags"))
  freeform_tags       = merge(var.freeform_tags, lookup(var.compute_cluster[count.index], "freeform_tags"))
}

resource "oci_core_compute_image_capability_schema" "this" {
  count                                               = length(var.compartment) == 0 ? 0 : length(var.compute_image_capability_schema)
  compartment_id                                      = try(element(module.identity.*.compartment_id, lookup(var.compute_image_capability_schema[count.index], "compartment_id")))
  compute_global_image_capability_schema_version_name = lookup(var.compute_image_capability_schema[count.index], "compute_global_image_capability_schema_version_name")
  image_id                                            = try(element(oci_core_image.this.*.id, lookup(var.compute_image_capability_schema[count.index], "image_id")))
  schema_data                                         = lookup(var.compute_image_capability_schema[count.index], "schema_data")
  display_name                                        = lookup(var.compute_image_capability_schema[count.index], "display_name")
  defined_tags                                        = merge(var.defined_tags, lookup(var.compute_image_capability_schema[count.index], "defined_tags"))
  freeform_tags                                       = merge(var.freeform_tags, lookup(var.compute_image_capability_schema[count.index], "freeform_tags"))
}

resource "oci_core_console_history" "this" {
  count         = length(var.instance) == 0 ? 0 : length(var.console_history)
  instance_id   = try(element(oci_core_instance.this.*.id, lookup(var.console_history[count.index],"instance_id" )))
  display_name  = lookup(var.console_history[count.index], "display_name")
  defined_tags  = merge(var.defined_tags, lookup(var.console_history[count.index], "defined_tags"))
  freeform_tags = merge(var.freeform_tags, lookup(var.console_history[count.index], "freeform_tags"))
}

resource "oci_core_cpe" "this" {
  compartment_id = ""
  ip_address     = ""
}

resource "oci_core_cross_connect" "this" {
  compartment_id        = ""
  location_name         = ""
  port_speed_shape_name = ""
}

resource "oci_core_cross_connect_group" "this" {
  compartment_id = ""
}

resource "oci_core_dedicated_vm_host" "this" {
  availability_domain     = ""
  compartment_id          = ""
  dedicated_vm_host_shape = ""
}

resource "oci_core_dhcp_options" "this" {
  compartment_id = ""
  vcn_id         = ""

  dynamic "options" {
    for_each = ""
    content {
      type = ""
    }
  }
}

resource "oci_core_drg" "this" {
  compartment_id = ""
}

resource "oci_core_drg_attachment" "this" {
  drg_id = ""
}

resource "oci_core_drg_attachment_management" "this" {
  attachment_type = ""
  compartment_id  = ""
  drg_id          = ""
}

resource "oci_core_drg_attachments_list" "this" {
  drg_id = ""
}

resource "oci_core_drg_route_distribution" "this" {
  distribution_type = ""
  drg_id            = ""
}

resource "oci_core_drg_route_distribution_statement" "this" {
  action                    = ""
  drg_route_distribution_id = ""
  priority                  = 0

  dynamic "match_criteria" {
    for_each = ""
    content {

    }
  }
}

resource "oci_core_drg_route_table" "this" {
  drg_id = ""
}

resource "oci_core_drg_route_table_route_rule" "this" {
  destination                = ""
  destination_type           = ""
  drg_route_table_id         = ""
  next_hop_drg_attachment_id = ""
}

resource "oci_core_image" "this" {
  compartment_id = ""
}

resource "oci_core_instance" "this" {
  availability_domain = ""
  compartment_id      = ""
}

resource "oci_core_instance_console_connection" "this" {
  instance_id = ""
  public_key  = ""
}

resource "oci_core_instance_pool" "this" {
  compartment_id            = ""
  instance_configuration_id = ""
  size                      = 0

  dynamic "placement_configurations" {
    for_each = ""
    content {
      availability_domain = ""
    }
  }
}

resource "oci_core_instance_pool_instance" "this" {
  instance_id      = ""
  instance_pool_id = ""
}

resource "oci_core_internet_gateway" "this" {
  compartment_id = ""
  vcn_id         = ""
}

resource "oci_core_ipsec" "this" {
  compartment_id = ""
  cpe_id         = ""
  drg_id         = ""
  static_routes  = []
}

resource "oci_core_ipsec_connection_tunnel_management" "this" {
  ipsec_id  = ""
  tunnel_id = ""
}

resource "oci_core_ipv6" "this" {
  vnic_id = ""
}

resource "oci_core_local_peering_gateway" "this" {
  compartment_id = ""
  vcn_id         = ""
}

resource "oci_core_nat_gateway" "this" {
  compartment_id = ""
  vcn_id         = ""
}

resource "oci_core_network_security_group" "this" {
  compartment_id = ""
  vcn_id         = ""
}

resource "oci_core_network_security_group_security_rule" "this" {
  direction                 = ""
  network_security_group_id = ""
  protocol                  = ""
}

resource "oci_core_private_ip" "this" {}

resource "oci_core_public_ip" "this" {
  compartment_id = ""
  lifetime       = ""
}

resource "oci_core_public_ip_pool" "this" {
  compartment_id = ""
}

resource "oci_core_public_ip_pool_capacity" "this" {
  byoip_id          = ""
  cidr_block        = ""
  public_ip_pool_id = ""
}

resource "oci_core_remote_peering_connection" "this" {
  compartment_id = ""
  drg_id         = ""
}

resource "oci_core_route_table" "this" {
  compartment_id = ""
  vcn_id         = ""
}

resource "oci_core_route_table_attachment" "this" {
  route_table_id = ""
  subnet_id      = ""
}

resource "oci_core_security_list" "this" {
  compartment_id = ""
  vcn_id         = ""
}

resource "oci_core_service_gateway" "this" {
  compartment_id = ""
  vcn_id         = ""

  dynamic "services" {
    for_each = ""
    content {
      service_id = ""
    }
  }
}

resource "oci_core_shape_management" "this" {
  compartment_id = ""
  image_id       = ""
  shape_name     = ""
}

resource "oci_core_subnet" "this" {
  cidr_block     = ""
  compartment_id = ""
  vcn_id         = ""
}

resource "oci_core_vcn" "this" {
  compartment_id = ""
}

resource "oci_core_virtual_circuit" "this" {
  compartment_id = ""
  type           = ""
}

resource "oci_core_virtual_network" "this" {
  compartment_id = ""
}

resource "oci_core_vlan" "this" {
  cidr_block     = ""
  compartment_id = ""
  vcn_id         = ""
}

resource "oci_core_vnic_attachment" "this" {
  instance_id = ""

  dynamic "create_vnic_details" {
    for_each = ""
    content {

    }
  }
}

resource "oci_core_volume" "his" {
  availability_domain = ""
  compartment_id      = ""
}

resource "oci_core_volume_attachment" "this" {
  attachment_type = ""
  instance_id     = ""
  volume_id       = ""
}

resource "oci_core_volume_backup" "this" {}

resource "oci_core_volume_backup_policy" "this" {
  compartment_id = ""
}

resource "oci_core_volume_backup_policy_assignment" "this" {
  asset_id  = ""
  policy_id = ""
}

resource "oci_core_volume_group" "this" {
  availability_domain = ""
  compartment_id      = ""

  dynamic "source_details" {
    for_each = ""
    content {
      type = ""
    }
  }
}

resource "oci_core_volume_group_backup" "this" {}

resource "oci_core_vtap" "this" {
  capture_filter_id = ""
  compartment_id    = ""
  source_id         = ""
  vcn_id            = ""
}