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
  count                         = length(var.compartment) == 0 ? 0 : length(var.boot_volume)
  availability_domain           = lookup(var.boot_volume[count.index], "availability_domain")
  compartment_id                = try(element(module.identity.*.compartment_id, lookup(var.boot_volume[count.index], "compartment_id")))
  cluster_placement_group_id    = try(element(module.identity.*.group_id, lookup(var.boot_volume[count.index], "cluster_placement_group_id")))
  defined_tags                  = merge(var.defined_tags, lookup(var.boot_volume[count.index], "defined_tags"))
  display_name                  = lookup(var.boot_volume[count.index], "display_name")
  freeform_tags                 = merge(var.freeform_tags, lookup(var.boot_volume[count.index], "freeform_tags"))
  is_auto_tune_enabled          = lookup(var.boot_volume[count.index], "is_auto_tune_enabled")
  kms_key_id                    = try(element(module.kms.*.key_id, lookup(var.boot_volume[count.index], "kms_key_id")))
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
  kms_key_id     = try(element(module.kms.*.key_id, lookup(var.boot_volume_backup[count.index], "kms-key_id")))
  type           = lookup(var.boot_volume_backup[count.index], "type")

  dynamic "source_details" {
    for_each = lookup(var.boot_volume_backup[count.index], "boot_volume_id") != null ? [] : lookup(var.boot_volume_backup[count.index], "source_details")
    content {
      boot_volume_backup_id = try(element(oci_core_boot_volume.this.*.id, lookup(source_details.value, "boot_volume_id")))
      region                = lookup(source_details.value, "region")
      kms_key_id            = try(element(module.kms.*.key_id, lookup(source_details.value, "kms-key_id")))
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
      instance_configuration_id = try(element(oci_core_instance_configuration.this.*.id, lookup(instance_pools.value, "instance_configuration_id")))
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
  instance_id   = try(element(oci_core_instance.this.*.id, lookup(var.console_history[count.index], "instance_id")))
  display_name  = lookup(var.console_history[count.index], "display_name")
  defined_tags  = merge(var.defined_tags, lookup(var.console_history[count.index], "defined_tags"))
  freeform_tags = merge(var.freeform_tags, lookup(var.console_history[count.index], "freeform_tags"))
}

resource "oci_core_cpe" "this" {
  count               = length(var.compartment) == 0 ? 0 : length(var.cpe)
  compartment_id      = try(element(module.identity.*.compartment_id, lookup(var.cpe[count.index], "compartment_id")))
  ip_address          = lookup(var.cpe[count.index], "ip_address")
  cpe_device_shape_id = try(element(oci_core_cpe.this.*.cpe_device_shape_id, lookup(var.cpe[count.index], "cpe_device_shape_id")))
  defined_tags        = merge(var.defined_tags, lookup(var.cpe[count.index], "defined_tags"))
  display_name        = lookup(var.cpe[count.index], "display_name")
  freeform_tags       = merge(var.freeform_tags, lookup(var.cpe[count.index], "freeform_tags"))
  is_private          = lookup(var.cpe[count.index], "is_private")
}

resource "oci_core_cross_connect" "this" {
  count                                        = length(var.compartment) == 0 ? 0 : length(var.cross_connect)
  compartment_id                               = try(element(module.identity.*.compartment_id, lookup(var.cross_connect[count.index], "compartment_id")))
  location_name                                = lookup(var.cross_connect[count.index], "location_name")
  port_speed_shape_name                        = lookup(var.cross_connect[count.index], "port_speed_shape_name")
  cross_connect_group_id                       = try(element(oci_core_cross_connect_group.this.*.id, lookup(var.cross_connect[count.index], "cross_connect_group_id")))
  customer_reference_name                      = lookup(var.cross_connect[count.index], "customer_reference_name")
  defined_tags                                 = merge(var.defined_tags, lookup(var.cross_connect[count.index], "defined_tags"))
  display_name                                 = lookup(var.cross_connect[count.index], "display_name")
  far_cross_connect_or_cross_connect_group_id  = try(element(oci_core_cross_connect_group.this.id, lookup(var.cross_connect[count.index], "far_cross_connect_or_cross_connect_group_id")))
  freeform_tags                                = merge(var.freeform_tags, lookup(var.cross_connect[count.index], "freeform_tags"))
  near_cross_connect_or_cross_connect_group_id = try(element(oci_core_cross_connect_group.this.id, lookup(var.cross_connect[count.index], "near_cross_connect_or_cross_connect_group_id")))

  dynamic "macsec_properties" {
    for_each = try(lookup(var.cross_connect[count.index], "macsec_properties") == null ? [] : ["macsec_properties"])
    content {
      state                          = lookup(macsec_properties.value, "state")
      encryption_cipher              = lookup(macsec_properties.value, "encryption_cipher")
      is_unprotected_traffic_allowed = lookup(macsec_properties.value, "is_unprotected_traffic_allowed")

      dynamic "primary_key" {
        for_each = try(lookup(macsec_properties.value, "primary_key") == null ? [] : ["primary_key"])
        content {
          connectivity_association_key_secret_id  = "tbd"
          connectivity_association_name_secret_id = "tbd"
        }
      }
    }
  }
}

resource "oci_core_cross_connect_group" "this" {
  count                   = length(var.compartment) == 0 ? 0 : length(var.cross_connect_group)
  compartment_id          = try(element(module.identity.*.compartment_id, lookup(var.cross_connect_group[count.index], "compartment_id")))
  customer_reference_name = lookup(var.cross_connect_group[count.index], "customer_reference_name")
  defined_tags            = merge(var.defined_tags, lookup(var.cross_connect_group[count.index], "defined_tags"))
  display_name            = lookup(var.cross_connect_group[count.index], "display_name")
  freeform_tags           = merge(var.freeform_tags, lookup(var.cross_connect_group[count.index], "freeform_tags"))

  dynamic "macsec_properties" {
    for_each = try(lookup(var.cross_connect_group[count.index], "macsec_properties") == null ? [] : ["macsec_properties"])
    content {
      state                          = lookup(macsec_properties.value, "state")
      encryption_cipher              = lookup(macsec_properties.value, "encryption_cipher")
      is_unprotected_traffic_allowed = lookup(macsec_properties.value, "is_unprotected_traffic_allowed")

      dynamic "primary_key" {
        for_each = try(lookup(macsec_properties.value, "primary_key") == null ? [] : ["primary_key"])
        content {
          connectivity_association_key_secret_id  = "tbd"
          connectivity_association_name_secret_id = "tbd"
        }
      }
    }
  }
}

resource "oci_core_dedicated_vm_host" "this" {
  count                   = length(var.compartment) == 0 ? 0 : length(var.dedicated_vm_host)
  availability_domain     = lookup(var.dedicated_vm_host[count.index], "availability_domain")
  compartment_id          = try(element(module.identity.*.compartment_id, lookup(var.dedicated_vm_host[count.index], "compartment_id")))
  dedicated_vm_host_shape = lookup(var.dedicated_vm_host[count.index], "dedicated_vm_host_shape")
  defined_tags            = merge(var.defined_tags, lookup(var.dedicated_vm_host[count.index], "defined_tags"))
  display_name            = lookup(var.dedicated_vm_host[count.index], "display_name")
  fault_domain            = lookup(var.dedicated_vm_host[count.index], "fault_domain")
  freeform_tags           = merge(var.freeform_tags, lookup(var.dedicated_vm_host[count.index], "freeform_tags"))
}

resource "oci_core_dhcp_options" "this" {
  count            = length(var.compartment) == 0 ? 0 : length(var.dhcp_options)
  compartment_id   = try(element(module.identity.*.compartment_id, lookup(var.dhcp_options[count.index], "compartment_id")))
  vcn_id           = try(element(oci_core_vcn.this.*.id, lookup(var.dhcp_options[count.index], "vcn_id")))
  defined_tags     = merge(var.defined_tags, lookup(var.dhcp_options[count.index], "defined_tags"))
  display_name     = lookup(var.dhcp_options[count.index], "display_name")
  domain_name_type = lookup(var.dhcp_options[count.index], "domain_name_type")
  freeform_tags    = merge(var.freeform_tags, lookup(var.dhcp_options[count.index], "freeform_tags"))

  dynamic "options" {
    for_each = lookup(var.dhcp_options[count.index], "options")
    content {
      type                = lookup(options.value, "type")
      custom_dns_servers  = lookup(options.value, "custom_dns_servers")
      search_domain_names = lookup(options.value, "search_domain_names")
      server_type         = lookup(options.value, "server_type")
    }
  }
}

resource "oci_core_drg" "this" {
  count          = length(var.compartment) == 0 ? 0 : length(var.drg)
  compartment_id = try(element(module.identity.*.compartment_id, lookup(var.drg[count.index], "compartment_id")))
  defined_tags   = merge(var.defined_tags, lookup(var.drg[count.index], "defined_tags"))
  display_name   = lookup(var.drg[count.index], "display_name")
  freeform_tags  = merge(var.freeform_tags, lookup(var.drg[count.index], "freeform_tags"))
}

resource "oci_core_drg_attachment" "this" {
  count              = length(var.drg) == 0 ? 0 : length(var.drg_attachment)
  drg_id             = try(element(oci_core_drg.this.*.id, lookup(var.drg_attachment[count.index], "drg_id")))
  defined_tags       = merge(var.defined_tags, lookup(var.drg_attachment[count.index], "defined_tags"))
  display_name       = lookup(var.drg_attachment[count.index], "display_name")
  drg_route_table_id = try(element(oci_core_drg_route_table.this.*.id, lookup(var.drg_attachment[count.index], "drg_route_table_id")))
  freeform_tags      = merge(var.freeform_tags, lookup(var.drg_attachment[count.index], "freeform_tags"))

  dynamic "network_details" {
    for_each = try(lookup(var.drg_attachment[count.index], "network_details") == null ? [] : ["network_details"])
    content {
      type           = lookup(network_details.value, "type")
      id             = try(length(var.vcn) != null ? element(oci_core_vcn.this.*.id, lookup(network_details.value, "id")) : lookup(network_details.value, "id"))
      route_table_id = try(element(oci_core_route_table.this.*.id, lookup(network_details.value, "route_table_id")))
      vcn_route_type = lookup(network_details.value, "vcn_route_type")
    }
  }
}

resource "oci_core_drg_attachment_management" "this" {
  count                                        = (length(var.compartment) && length(var.drg)) == 0 ? 0 : length(var.drg_attachment_management)
  attachment_type                              = lookup(var.drg_attachment_management[count.index], "attachment_type")
  compartment_id                               = try(element(module.identity.*.compartment_id, lookup(var.drg_attachment_management[count.index], "compartment_id")))
  drg_id                                       = try(element(oci_core_drg.this.*.id, lookup(var.drg_attachment_management[count.index], "drg_id")))
  defined_tags                                 = merge(var.defined_tags, lookup(var.drg_attachment_management[count.index], "defined_tags"))
  display_name                                 = lookup(var.drg_attachment_management[count.index], "display_name")
  drg_route_table_id                           = try(element(oci_core_drg_route_table.this.*.id, lookup(var.drg_attachment_management[count.index], "drg_route_table_id")))
  export_drg_route_distribution_id             = try(element(oci_core_drg_route_distribution.this.*.id, lookup(var.drg_attachment_management[count.index], "export_drg_route_distribution_id")))
  freeform_tags                                = merge(var.freeform_tags, lookup(var.drg_attachment_management[count.index], "freeform_tags"))
  network_id                                   = try(element(oci_core_remote_peering_connection.this.*.id, lookup(var.drg_attachment_management[count.index], "network_id")))
  remove_export_drg_route_distribution_trigger = lookup(var.drg_attachment_management[count.index], "remove_export_drg_route_distribution_trigger")
  route_table_id                               = try(element(oci_core_route_table.this.*.id, lookup(var.drg_attachment_management[count.index], "route_table_id")))
  vcn_id                                       = try(element(oci_core_vcn.this.*.id, lookup(var.drg_attachment_management[count.index], "vcn_id")))

  dynamic "network_details" {
    for_each = try(lookup(var.drg_attachment_management[count.index], "network_details") == null ? [] : ["network_details"])
    content {
      id                  = try(element(oci_core_virtual_network.this.*.id, lookup(network_details.value, "id")))
      type                = lookup(network_details.value, "type")
      route_table_id      = try(element(oci_core_route_table.this.*.id, lookup(network_details.value, "route_table_id")))
      ipsec_connection_id = try(element(oci_core_ipsec.this.*.id, lookup(network_details.value, "ipsec_connection_id")))
    }
  }
}

resource "oci_core_drg_attachments_list" "this" {
  count            = length(var.drg) == 0 ? 0 : length(var.drg_attachments_list)
  drg_id           = try(element(oci_core_drg.this.*.id, lookup(var.drg_attachments_list[count.index], "drg_id")))
  attachment_type  = lookup(var.drg_attachments_list[count.index], "attachment_type")
  is_cross_tenancy = lookup(var.drg_attachments_list[count.index], "is_cross_tenancy")
}

resource "oci_core_drg_route_distribution" "this" {
  count             = length(var.drg) == 0 ? 0 : length(var.drg_route_distribution)
  distribution_type = lookup(var.drg_route_distribution[count.index], "distribution_type")
  drg_id            = try(element(oci_core_drg.this.*.id, lookup(var.drg_route_distribution[count.index], "drg_id")))
  defined_tags      = merge(var.defined_tags, lookup(var.drg_route_distribution[count.index], "defined_tags"))
  display_name      = lookup(var.drg_route_distribution[count.index], "display_name")
  freeform_tags     = merge(var.freeform_tags, lookup(var.drg_route_distribution[count.index], "freeform_tags"))
}

resource "oci_core_drg_route_distribution_statement" "this" {
  count                     = length(var.drg_route_distribution) == 0 ? 0 : length(var.drg_route_distribution_statement)
  action                    = lookup(var.drg_route_distribution_statement[count.index], "action")
  drg_route_distribution_id = try(element(oci_core_drg_route_distribution.this.*.id, lookup(var.drg_route_distribution_statement[count.index], "drg_route_distribution_id")))
  priority                  = lookup(var.drg_route_distribution_statement[count.index], "priority")

  dynamic "match_criteria" {
    for_each = lookup(var.drg_route_distribution_statement[count.index], "match_criteria")
    content {
      match_type        = lookup(match_criteria.value, "match_type")
      attachment_type   = lookup(match_criteria.value, "attachment_type")
      drg_attachment_id = try(element(oci_core_drg_attachment.this.*.id, lookup(match_criteria.value, "drg_attachment_id")))
    }
  }
}

resource "oci_core_drg_route_table" "this" {
  count                            = length(var.drg) == 0 ? 0 : length(var.drg_route_table)
  drg_id                           = try(element(oci_core_drg.this.*.id, lookup(var.drg_route_table[count.index], "drg_id")))
  defined_tags                     = merge(var.defined_tags, lookup(var.drg_route_table[count.index], "defined_tags"))
  display_name                     = lookup(var.drg_route_table[count.index], "display_name")
  freeform_tags                    = merge(var.freeform_tags, lookup(var.drg_route_table[count.index], "freeform_tags"))
  import_drg_route_distribution_id = try(element(oci_core_drg_route_distribution.this.*.id, lookup(var.drg_route_table[count.index], "import_drg_route_distribution_id")))
  is_ecmp_enabled                  = lookup(var.drg_route_table[count.index], "is_ecmp_enabled")
  remove_import_trigger            = lookup(var.drg_route_table[count.index], "remove_import_trigger")
}

resource "oci_core_drg_route_table_route_rule" "this" {
  count                      = (length(var.drg_attachment) && length(var.drg_route_table)) == 0 ? 0 : length(var.drg_route_table_route_rule)
  destination                = lookup(var.drg_route_table_route_rule[count.index], "destination")
  destination_type           = lookup(var.drg_route_table_route_rule[count.index], "destination_type")
  drg_route_table_id         = try(element(oci_core_drg_route_table.this.*.id, lookup(var.drg_route_table_route_rule[count.index], "drg_route_table_id")))
  next_hop_drg_attachment_id = try(element(oci_core_drg_attachment.this.*.id, lookup(var.drg_route_table_route_rule[count.index], "next_hop_drg_attachment_id")))
}

resource "oci_core_image" "this" {
  count          = length(var.compartment) == 0 ? 0 : length(var.image)
  compartment_id = try(element(module.identity.*.compartment_id, lookup(var.image[count.index], "compartment_id")))
  defined_tags   = merge(var.defined_tags, lookup(var.image[count.index], "defined_tags"))
  display_name   = lookup(var.image[count.index], "display_name")
  freeform_tags  = merge(var.freeform_tags, lookup(var.image[count.index], "freeform_tags"))
  instance_id    = try(element(oci_core_instance.this.*.id, lookup(var.image[count.index], "instance_id")))
  launch_mode    = lookup(var.image[count.index], "launch_mode")

  dynamic "image_source_details" {
    for_each = try(lookup(var.image[count.index], "image_source_details") == null ? [] : ["image_source_details"])
    iterator = details
    content {
      source_type              = lookup(details.value, "source_type")
      namespace_name           = lookup(details.value, "namespace_name")
      object_name              = lookup(details.value, "object_name")
      operating_system         = lookup(details.value, "operating_system")
      operating_system_version = lookup(details.value, "operating_system_version")
      source_image_type        = lookup(details.value, "source_image_type")
      source_uri               = lookup(details.value, "source_uri")
    }
  }
}

resource "oci_core_instance" "this" {
  count                                   = length(var.compartment) == 0 ? 0 : length(var.instance)
  availability_domain                     = lookup(var.instance[count.index], "availability_domain")
  compartment_id                          = try(element(module.identity.*.compartment_id, lookup(var.instance[count.index], "compartment_id")))
  shape                                   = lookup(var.instance[count.index], "shape")
  async                                   = lookup(var.instance[count.index], "async")
  capacity_reservation_id                 = try(element(oci_core_compute_capacity_reservation.this.*.id, lookup(var.instance[count.index], "capacity_reservation_id")))
  cluster_placement_group_id              = try(element(module.identity.*.group_id, lookup(var.instance[count.index], "cluster_placement_group_id")))
  compute_cluster_id                      = try(element(oci_core_compute_cluster.this.*.id, lookup(var.instance[count.index], "compute_cluster_id")))
  dedicated_vm_host_id                    = try(element(oci_core_dedicated_vm_host.this.*.id, lookup(var.instance[count.index], "dedicated_vm_host_id")))
  defined_tags                            = merge(var.defined_tags, lookup(var.instance[count.index], "defined_tags"))
  display_name                            = lookup(var.instance[count.index], "display_name")
  extended_metadata                       = lookup(var.instance[count.index], "extended_metadata")
  fault_domain                            = lookup(var.instance[count.index], "fault_domain")
  freeform_tags                           = merge(var.freeform_tags, lookup(var.instance[count.index], "freeform_tags"))
  instance_configuration_id               = try(element(oci_core_instance.this.*.instance_configuration_id, lookup(var.instance[count.index], "instance_configuration_id")))
  ipxe_script                             = lookup(var.instance[count.index], "ipxe_script")
  is_pv_encryption_in_transit_enabled     = lookup(var.instance[count.index], "is_pv_encryption_in_transit_enabled")
  metadata                                = lookup(var.instance[count.index], "metadata")
  preserve_boot_volume                    = lookup(var.instance[count.index], "preserve_boot_volume")
  preserve_data_volumes_created_at_launch = lookup(var.instance[count.index], "preserve_data_volumes_created_at_launch")
  state                                   = lookup(var.instance[count.index], "state")
  update_operation_constraint             = lookup(var.instance[count.index], "update_operation_constraint")

  dynamic "agent_config" {
    for_each = try(lookup(var.instance[count.index], "agent_config") == null ? [] : ["agent_config"])
    iterator = agent
    content {
      are_all_plugins_disabled = lookup(agent.value, "are_all_plugins_disabled")
      is_management_disabled   = lookup(agent.value, "is_management_disabled")
      is_monitoring_disabled   = lookup(agent.value, "is_monitoring_disabled")

      dynamic "plugins_config" {
        for_each = try(lookup(agent.value, "plugins_config") == null ? [] : ["plugins_config"])
        content {
          desired_state = lookup(plugins_config.value, "desired_state")
          name          = lookup(plugins_config.value, "name")
        }
      }
    }
  }

  dynamic "availability_config" {
    for_each = try(lookup(var.instance[count.index], "availability_config") == null ? [] : ["availability_config"])
    iterator = availability
    content {
      is_live_migration_preferred = lookup(availability.value, "is_live_migration_preferred")
      recovery_action             = lookup(availability.value, "recovery_action")
    }
  }

  dynamic "create_vnic_details" {
    for_each = try(lookup(var.instance[count.index], "create_vnic_details") == null ? [] : ["create_vnic_details"])
    iterator = vnic
    content {
      assign_ipv6ip             = lookup(vnic.value, "assign_ipv6ip")
      assign_private_dns_record = lookup(vnic.value, "assign_private_dns_record")
      assign_public_ip          = lookup(vnic.value, "assign_public_ip")
      defined_tags              = merge(var.defined_tags, lookup(vnic.value, "defined_tags"))
      display_name              = lookup(vnic.value, "display_name")
      freeform_tags             = merge(var.freeform_tags, lookup(vnic.value, "freeform_tags"))
      hostname_label            = lookup(vnic.value, "hostname_label")
      nsg_ids                   = lookup(vnic.value, "nsg_ids")
      private_ip                = lookup(vnic.value, "private_ip")
      skip_source_dest_check    = lookup(vnic.value, "skip_source_dest_check")
      subnet_id                 = try(element(oci_core_subnet.this.*.id, lookup(vnic.value, "subnet_id")))
      vlan_id                   = try(element(oci_core_vlan.this.*.id, lookup(vnic.value, "vlan_id")))
    }
  }

  dynamic "instance_options" {
    for_each = try(lookup(var.instance[count.index], "instance_options") == null ? [] : ["instance_options"])
    iterator = instance
    content {
      are_legacy_imds_endpoints_disabled = lookup(instance.value, "are_legacy_imds_endpoints_disabled")
    }
  }

  dynamic "launch_options" {
    for_each = try(lookup(var.instance[count.index], "launch_options") == null ? [] : ["launch_options"])
    iterator = launch
    content {
      boot_volume_type                    = lookup(launch.value, "boot_volume_type")
      firmware                            = lookup(launch.value, "firmware")
      is_consistent_volume_naming_enabled = lookup(launch.value, "is_consistent_volume_naming_enabled")
      is_pv_encryption_in_transit_enabled = lookup(launch.value, "is_pv_encryption_in_transit_enabled")
      network_type                        = lookup(launch.value, "network_type")
      remote_data_volume_type             = lookup(launch.value, "remote_data_volume_type")
    }
  }

  dynamic "launch_volume_attachments" {
    for_each = try(lookup(var.instance[count.index], "launch_volume_attachments") == null ? [] : ["launch_volume_attachments"])
    iterator = volume
    content {
      type                              = lookup(volume.value, "type")
      device                            = lookup(volume.value, "device")
      display_name                      = lookup(volume.value, "display_name")
      encryption_in_transit_type        = lookup(volume.value, "encryption_in_transit_type")
      is_agent_auto_iscsi_login_enabled = lookup(volume.value, "is_agent_auto_iscsi_login_enabled")
      is_read_only                      = lookup(volume.value, "is_read_only")
      is_shareable                      = lookup(volume.value, "is_shareable")
      use_chap                          = lookup(volume.value, "use_chap")
      volume_id                         = try(element(oci_core_boot_volume.this.*.id, lookup(volume.value, "volume_id")))

      dynamic "launch_create_volume_details" {
        for_each = try(lookup(volume.value, "launch_create_volume_details") == null ? [] : ["launch_create_volume_details"])
        iterator = details
        content {
          size_in_gbs          = lookup(details.value, "size_in_gbs")
          volume_creation_type = lookup(details.value, "volume_creation_type")
          compartment_id       = try(element(module.identity.*.compartment_id, lookup(details.value, "compartment_id")))
          display_name         = lookup(details.value, "display_name")
          kms_key_id           = try(element(module.kms.*.key_id, lookup(details.value, "kms_key_id")))
          vpus_per_gb          = lookup(details.value, "vpus_per_gb")
        }
      }
    }
  }

  dynamic "platform_config" {
    for_each = try(lookup(var.instance[count.index], "platform_config") == null ? [] : ["platform_config"])
    iterator = platform
    content {
      type                                           = lookup(platform.value, "type")
      are_virtual_instructions_enabled               = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" ? lookup(platform.value, "are_virtual_instructions_enabled") : null
      config_map                                     = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "config_map") : null
      is_access_control_service_enabled              = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" ? lookup(platform.value, "is_access_control_service_enabled") : null
      is_input_output_memory_management_unit_enabled = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "is_input_output_memory_management_unit_enabled") : null
      is_measured_boot_enabled                       = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" || lookup(platform.value, "type") == "INTEL_VM" ? lookup(platform.value, "is_measured_boot_enabled") : null
      is_memory_encryption_enabled                   = lookup(platform.value, "is_memory_encryption_enabled")
      is_secure_boot_enabled                         = lookup(platform.value, "is_secure_boot_enabled")
      is_symmetric_multi_threading_enabled           = lookup(platform.value, "is_symmetric_multi_threading_enabled")
      is_trusted_platform_module_enabled             = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "is_trusted_platform_module_enabled") : null
      numa_nodes_per_socket                          = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "numa_nodes_per_socket") : null
      percentage_of_cores_enabled                    = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "percentage_of_cores_enabled") : null
    }
  }

  dynamic "preemptible_instance_config" {
    for_each = try(lookup(var.instance[count.index], "preemptible_instance_config") == null ? [] : ["preemptible_instance_config"])
    iterator = preemptible
    content {
      dynamic "preemption_action" {
        for_each = lookup(preemptible.value, "preemption_action")
        iterator = action
        content {
          type                 = lookup(action.value, "type")
          preserve_boot_volume = lookup(action.value, "preserve_boot_volume")
        }
      }
    }
  }

  dynamic "shape_config" {
    for_each = try(lookup(var.instance[count.index], "shape_config") == null ? [] : ["shape_config"])
    iterator = shape
    content {
      baseline_ocpu_utilization = lookup(shape.value, "baseline_ocpu_utilization")
      memory_in_gbs             = lookup(shape.value, "memory_in_gbs")
      nvmes                     = lookup(shape.value, "nvmes")
      ocpus                     = lookup(shape.value, "ocpus")
      vcpus                     = lookup(shape.value, "vcpus")
    }
  }

  dynamic "source_details" {
    for_each = try(lookup(var.instance[count.index], "source_details") == null ? [] : ["source_details"])
    iterator = source
    content {
      source_type                     = lookup(source.value, "source_type")
      source_id                       = try(element(oci_core_image.this.*.id, lookup(source.value, "image_id")))
      boot_volume_size_in_gbs         = lookup(source.value, "boot_volume_size_in_gbs")
      boot_volume_vpus_per_gb         = lookup(source.value, "boot_volume_vpus_per_gb")
      kms_key_id                      = try(element(module.kms.*.key_id, lookup(source.value, "kms_key_id")))
      is_preserve_boot_volume_enabled = lookup(source.value, "is_preserve_boot_volume_enabled")

      dynamic "instance_source_image_filter_details" {
        for_each = try(lookup(source.value, "instance_source_image_filter_details") == null ? [] : ["instance_source_image_filter_details"])
        iterator = filter
        content {
          compartment_id           = try(element(module.identity.*.compartment_id, lookup(filter.value, "compartment_id")))
          defined_tags_filter      = lookup(filter.value, "defined_tags_filter")
          operating_system         = lookup(filter.value, "operating_system")
          operating_system_version = lookup(filter.value, "operating_system_version")
        }
      }
    }
  }
}

resource "oci_core_instance_console_connection" "this" {
  count         = length(var.instance) == 0 ? 0 : length(var.instance_console_connection)
  instance_id   = try(element(oci_core_instance.this.*.id, lookup(var.instance_console_connection[count.index], "instance_id")))
  public_key    = file(join("/", [path.cwd, "keys", lookup(var.instance_console_connection[count.index], "public_key")]))
  defined_tags  = merge(var.defined_tags, lookup(var.instance_console_connection[count.index], "defined_tags"))
  freeform_tags = merge(var.freeform_tags, lookup(var.instance_console_connection[count.index], "freefor_tags"))
}

resource "oci_core_instance_configuration" "this" {
  count          = length(var.compartment) == 0 ? 0 : length(var.instance_configuration)
  compartment_id = try(element(module.identity.*.compartment_id, lookup(var.instance_configuration[count.index], "compartment_id")))
  defined_tags   = merge(var.defined_tags, lookup(var.instance_configuration[count.index], "defined_tags"))
  display_name   = lookup(var.instance_configuration[count.index], "display_name")
  freeform_tags  = merge(var.freeform_tags, lookup(var.instance_configuration[count.index], "freeform_tags"))
  instance_id    = try(element(oci_core_instance.this.*.id, lookup(var.instance_configuration[count.index], "instance_id")))
  source         = lookup(var.instance_configuration[count.index], "source")

  dynamic "instance_details" {
    for_each = try(lookup(var.instance_configuration[count.index], "instance_details") == null ? [] : ["instance_details"])
    content {
      instance_type = lookup(instance_details.value, "instance_type")

      dynamic "block_volumes" {
        for_each = try(lookup(instance_details.value, "block_volumes") == null ? [] : ["block_volumes"])
        content {
          dynamic "attach_details" {
            for_each = try(lookup(block_volumes.value, "attach_details") == null ? [] : ["attach_details"])
            iterator = attach
            content {
              type                                = lookup(attach.value, "type")
              device                              = lookup(attach.value, "device")
              display_name                        = lookup(attach.value, "display_name")
              is_pv_encryption_in_transit_enabled = lookup(attach.value, "is_pv_encryption_in_transit_enabled")
              is_read_only                        = lookup(attach.value, "is_read_only")
              is_shareable                        = lookup(attach.value, "is_shareable")
              use_chap                            = lookup(attach.value, "use_chap")
            }
          }

          dynamic "create_details" {
            for_each = try(lookup(block_volumes.value, "create_details") == null ? [] : ["create_details"])
            iterator = create
            content {
              availability_domain        = lookup(create.value, "availability_domain")
              backup_policy_id           = try(element(oci_core_volume_backup_policy.this.*.id, lookup(create.value, "backup_policy_id")))
              cluster_placement_group_id = try(element(module.identity.*.group_id, lookup(create.value, "cluster_placement_group_id")))
              compartment_id             = try(element(module.identity.*.compartment_id, lookup(create.value, "compartment_id")))
              defined_tags               = lookup(create.value, "defined_tags")
              display_name               = lookup(create.value, "display_name")
              freeform_tags              = lookup(create.value, "freeform_tags")
              is_auto_tune_enabled       = lookup(create.value, "is_auto_tune_enabled")
              kms_key_id                 = try(element(module.kms.*.key_id, lookup(create.value, "kms_key_id")))
              size_in_gbs                = lookup(create.value, "size_in_gbs")
              vpus_per_gb                = lookup(create.value, "vpus_per_gb")

              dynamic "autotune_policies" {
                for_each = try(lookup(create.value, "autotune_policies") == null ? [] : ["autotune_policies"])
                iterator = autotune
                content {
                  autotune_type   = lookup(autotune.value, "autotune_type")
                  max_vpus_per_gb = lookup(autotune.value, "max_vpus_per_gb")
                }
              }

              dynamic "block_volume_replicas" {
                for_each = try(lookup(create.value, "block_volume_replicas") == null ? [] : ["block_volume_replicas"])
                iterator = replicas
                content {
                  availability_domain = lookup(replicas.value, "availability_domain")
                  display_name        = lookup(replicas.value, "display_name")
                }
              }

              dynamic "source_details" {
                for_each = try(lookup(create.value, "source_details") == null ? [] : ["source_details"])
                iterator = details
                content {
                  type = lookup(details.value, "type")
                }
              }
            }
          }
        }
      }

      dynamic "launch_details" {
        for_each = try(lookup(instance_details.value, "launch_details") == null ? [] : ["launch_details"])
        iterator = launch
        content {
          availability_domain                 = lookup(launch.value, "availability_domain")
          capacity_reservation_id             = try(element(oci_core_compute_capacity_reservation.this.*.id, lookup(launch.value, "capacity_reservation_id")))
          cluster_placement_group_id          = try(element(module.identity.*.group_id, lookup(launch.value, "cluster_placement_group_id")))
          compartment_id                      = try(element(module.identity.*.compartment_id, lookup(launch.value, "compartment_id")))
          dedicated_vm_host_id                = try(element(oci_core_dedicated_vm_host.this.*.id, lookup(launch.value, "dedicated_vm_host_id")))
          defined_tags                        = merge(var.defined_tags, lookup(launch.value, "defined_tags"))
          display_name                        = lookup(launch.value, "display_name")
          extended_metadata                   = lookup(launch.value, "extended_metadata")
          fault_domain                        = lookup(launch.value, "fault_domain")
          freeform_tags                       = merge(var.freeform_tags, lookup(launch.value, "freeform_tags"))
          ipxe_script                         = lookup(launch.value, "ipxe_script")
          is_pv_encryption_in_transit_enabled = lookup(launch.value, "is_pv_encryption_in_transit_enabled")
          launch_mode                         = lookup(launch.value, "launch_mode")
          metadata                            = lookup(launch.value, "metadata")
          preferred_maintenance_action        = lookup(launch.value, "preferred_maintenance_action")
          shape                               = lookup(launch.value, "shape")

          dynamic "agent_config" {
            for_each = try(lookup(launch.value, "agent_config") == null ? [] : ["agent_config"])
            iterator = agent
            content {
              are_all_plugins_disabled = lookup(agent.value, "are_all_plugins_disabled")
              is_management_disabled   = lookup(agent.value, "is_management_disabled")
              is_monitoring_disabled   = lookup(agent.value, "is_monitoring_disabled")

              dynamic "plugins_config" {
                for_each = try(lookup(agent.value, "plugins_config") == null ? [] : ["plugins_config"])
                content {
                  desired_state = lookup(plugins_config.value, "desired_state")
                  name          = lookup(plugins_config.value, "name")
                }
              }
            }
          }

          dynamic "availability_config" {
            for_each = try(lookup(launch.value, "availability_config") == null ? [] : ["availability_config"])
            iterator = availability
            content {
              is_live_migration_preferred = lookup(availability.value, "is_live_migration_preferred")
              recovery_action             = lookup(availability.value, "recovery_action")
            }
          }

          dynamic "create_vnic_details" {
            for_each = try(lookup(launch.value, "create_vnic_details") == null ? [] : ["create_vnic_details"])
            iterator = vnic
            content {
              assign_ipv6ip             = lookup(vnic.value, "assign_ipv6ip")
              assign_private_dns_record = lookup(vnic.value, "assign_private_dns_record")
              assign_public_ip          = lookup(vnic.value, "assign_public_ip")
              defined_tags              = merge(var.defined_tags, lookup(vnic.value, "defined_tags"))
              display_name              = lookup(vnic.value, "display_name")
              freeform_tags             = merge(var.freeform_tags, lookup(vnic.value, "freeform_tags"))
              hostname_label            = lookup(vnic.value, "hostname_label")
              nsg_ids                   = lookup(vnic.value, "nsg_ids")
              private_ip                = lookup(vnic.value, "private_ip")
              skip_source_dest_check    = lookup(vnic.value, "skip_source_dest_check")
              subnet_id                 = try(element(oci_core_subnet.this.*.id, lookup(vnic.value, "subnet_id")))
              #vlan_id                   = try(element(oci_core_vlan.this.*.id, lookup(vnic.value, "vlan_id")))
            }
          }

          dynamic "instance_options" {
            for_each = try(lookup(launch.value, "instance_options") == null ? [] : ["instance_options"])
            iterator = instance
            content {
              are_legacy_imds_endpoints_disabled = lookup(instance.value, "are_legacy_imds_endpoints_disabled")
            }
          }

          dynamic "launch_options" {
            for_each = try(lookup(launch.value, "launch_options") == null ? [] : ["launch_options"])
            iterator = launch
            content {
              boot_volume_type                    = lookup(launch.value, "boot_volume_type")
              firmware                            = lookup(launch.value, "firmware")
              is_consistent_volume_naming_enabled = lookup(launch.value, "is_consistent_volume_naming_enabled")
              is_pv_encryption_in_transit_enabled = lookup(launch.value, "is_pv_encryption_in_transit_enabled")
              network_type                        = lookup(launch.value, "network_type")
              remote_data_volume_type             = lookup(launch.value, "remote_data_volume_type")
            }
          }

          dynamic "launch_volume_attachments" {
            for_each = try(lookup(launch.value, "launch_volume_attachments") == null ? [] : ["launch_volume_attachments"])
            iterator = volume
            content {
              type                              = lookup(volume.value, "type")
              device                            = lookup(volume.value, "device")
              display_name                      = lookup(volume.value, "display_name")
              encryption_in_transit_type        = lookup(volume.value, "encryption_in_transit_type")
              is_agent_auto_iscsi_login_enabled = lookup(volume.value, "is_agent_auto_iscsi_login_enabled")
              is_read_only                      = lookup(volume.value, "is_read_only")
              is_shareable                      = lookup(volume.value, "is_shareable")
              use_chap                          = lookup(volume.value, "use_chap")
              volume_id                         = try(element(oci_core_boot_volume.this.*.id, lookup(volume.value, "volume_id")))

              dynamic "launch_create_volume_details" {
                for_each = try(lookup(volume.value, "launch_create_volume_details") == null ? [] : ["launch_create_volume_details"])
                iterator = details
                content {
                  size_in_gbs          = lookup(details.value, "size_in_gbs")
                  volume_creation_type = lookup(details.value, "volume_creation_type")
                  compartment_id       = try(element(module.identity.*.compartment_id, lookup(details.value, "compartment_id")))
                  display_name         = lookup(details.value, "display_name")
                  kms_key_id           = try(element(module.kms.*.key_id, lookup(details.value, "kms_key_id")))
                  vpus_per_gb          = lookup(details.value, "vpus_per_gb")
                }
              }
            }
          }

          dynamic "platform_config" {
            for_each = try(lookup(launch.value, "platform_config") == null ? [] : ["platform_config"])
            iterator = platform
            content {
              type                                           = lookup(platform.value, "type")
              are_virtual_instructions_enabled               = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" ? lookup(platform.value, "are_virtual_instructions_enabled") : null
              config_map                                     = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "config_map") : null
              is_access_control_service_enabled              = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" ? lookup(platform.value, "is_access_control_service_enabled") : null
              is_input_output_memory_management_unit_enabled = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "is_input_output_memory_management_unit_enabled") : null
              is_measured_boot_enabled                       = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" || lookup(platform.value, "type") == "INTEL_VM" ? lookup(platform.value, "is_measured_boot_enabled") : null
              is_memory_encryption_enabled                   = lookup(platform.value, "is_memory_encryption_enabled")
              is_secure_boot_enabled                         = lookup(platform.value, "is_secure_boot_enabled")
              is_symmetric_multi_threading_enabled           = lookup(platform.value, "is_symmetric_multi_threading_enabled")
              is_trusted_platform_module_enabled             = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "is_trusted_platform_module_enabled") : null
              numa_nodes_per_socket                          = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "numa_nodes_per_socket") : null
              percentage_of_cores_enabled                    = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "percentage_of_cores_enabled") : null
            }
          }

          dynamic "preemptible_instance_config" {
            for_each = try(lookup(launch.value, "preemptible_instance_config") == null ? [] : ["preemptible_instance_config"])
            iterator = preemptible
            content {
              dynamic "preemption_action" {
                for_each = lookup(preemptible.value, "preemption_action")
                iterator = action
                content {
                  type                 = lookup(action.value, "type")
                  preserve_boot_volume = lookup(action.value, "preserve_boot_volume")
                }
              }
            }
          }

          dynamic "shape_config" {
            for_each = try(lookup(launch.value, "shape_config") == null ? [] : ["shape_config"])
            iterator = shape
            content {
              baseline_ocpu_utilization = lookup(shape.value, "baseline_ocpu_utilization")
              memory_in_gbs             = lookup(shape.value, "memory_in_gbs")
              nvmes                     = lookup(shape.value, "nvmes")
              ocpus                     = lookup(shape.value, "ocpus")
              vcpus                     = lookup(shape.value, "vcpus")
            }
          }

          dynamic "source_details" {
            for_each = try(lookup(launch.value, "source_details") == null ? [] : ["source_details"])
            iterator = source
            content {
              source_type = lookup(source.value, "source_type")
              #source_id                       = try(element(oci_core_image.this.*.id, lookup(source.value, "image_id")))
              boot_volume_size_in_gbs = lookup(source.value, "boot_volume_size_in_gbs")
              boot_volume_vpus_per_gb = lookup(source.value, "boot_volume_vpus_per_gb")
              kms_key_id              = try(element(module.kms.*.key_id, lookup(source.value, "kms_key_id")))
              #is_preserve_boot_volume_enabled = lookup(source.value, "is_preserve_boot_volume_enabled")

              dynamic "instance_source_image_filter_details" {
                for_each = try(lookup(source.value, "instance_source_image_filter_details") == null ? [] : ["instance_source_image_filter_details"])
                iterator = filter
                content {
                  compartment_id           = try(element(module.identity.*.compartment_id, lookup(filter.value, "compartment_id")))
                  defined_tags_filter      = lookup(filter.value, "defined_tags_filter")
                  operating_system         = lookup(filter.value, "operating_system")
                  operating_system_version = lookup(filter.value, "operating_system_version")
                }
              }
            }
          }
        }
      }

      dynamic "options" {
        for_each = try(lookup(instance_details.value, "options") == null ? [] : ["options"])
        content {
          dynamic "block_volumes" {
            for_each = try(lookup(options.value, "block_volumes") == null ? [] : ["block_volumes"])
            iterator = block
            content {
              volume_id = try(element(oci_core_volume.this.*.id, lookup(block.value, "volume_id")))

              dynamic "attach_details" {
                for_each = try(lookup(block.value, "attach_details") == null ? [] : ["attach_details"])
                iterator = attach
                content {
                  type                                = lookup(attach.value, "type")
                  device                              = lookup(attach.value, "device")
                  display_name                        = lookup(attach.value, "display_name")
                  is_pv_encryption_in_transit_enabled = lookup(attach.value, "is_pv_encryption_in_transit_enabled")
                  is_read_only                        = lookup(attach.value, "is_read_only")
                  is_shareable                        = lookup(attach.value, "is_shareable")
                  use_chap                            = lookup(attach.value, "use_chap")
                }
              }

              dynamic "create_details" {
                for_each = try(lookup(block.value, "create_details") == null ? [] : ["create_details"])
                iterator = create
                content {
                  availability_domain        = lookup(create.value, "availability_domain")
                  backup_policy_id           = try(element(oci_core_volume_backup_policy.this.*.id, lookup(create.value, "backup_policy_id")))
                  cluster_placement_group_id = try(element(module.identity.*.group_id, lookup(create.value, "cluster_placement_group_id")))
                  compartment_id             = try(element(module.identity.*.compartment_id, lookup(create.value, "compartment_id")))
                  defined_tags               = lookup(create.value, "defined_tags")
                  display_name               = lookup(create.value, "display_name")
                  freeform_tags              = lookup(create.value, "freeform_tags")
                  is_auto_tune_enabled       = lookup(create.value, "is_auto_tune_enabled")
                  kms_key_id                 = try(element(module.kms.*.key_id, lookup(create.value, "kms_key_id")))
                  size_in_gbs                = lookup(create.value, "size_in_gbs")
                  vpus_per_gb                = lookup(create.value, "vpus_per_gb")

                  dynamic "autotune_policies" {
                    for_each = try(lookup(create.value, "autotune_policies") == null ? [] : ["autotune_policies"])
                    iterator = autotune
                    content {
                      autotune_type   = lookup(autotune.value, "autotune_type")
                      max_vpus_per_gb = lookup(autotune.value, "max_vpus_per_gb")
                    }
                  }

                  dynamic "block_volume_replicas" {
                    for_each = try(lookup(create.value, "block_volume_replicas") == null ? [] : ["block_volume_replicas"])
                    iterator = replicas
                    content {
                      availability_domain = lookup(replicas.value, "availability_domain")
                      display_name        = lookup(replicas.value, "display_name")
                    }
                  }

                  dynamic "source_details" {
                    for_each = try(lookup(create.value, "source_details") == null ? [] : ["source_details"])
                    iterator = details
                    content {
                      type = lookup(details.value, "type")
                    }
                  }
                }
              }
            }
          }

          dynamic "launch_details" {
            for_each = try(lookup(instance_details.value, "launch_details") == null ? [] : ["launch_details"])
            iterator = launch
            content {
              availability_domain                 = lookup(launch.value, "availability_domain")
              capacity_reservation_id             = try(element(oci_core_compute_capacity_reservation.this.*.id, lookup(launch.value, "capacity_reservation_id")))
              cluster_placement_group_id          = try(element(module.identity.*.group_id, lookup(launch.value, "cluster_placement_group_id")))
              compartment_id                      = try(element(module.identity.*.compartment_id, lookup(launch.value, "compartment_id")))
              dedicated_vm_host_id                = try(element(oci_core_dedicated_vm_host.this.*.id, lookup(launch.value, "dedicated_vm_host_id")))
              defined_tags                        = merge(var.defined_tags, lookup(launch.value, "defined_tags"))
              display_name                        = lookup(launch.value, "display_name")
              extended_metadata                   = lookup(launch.value, "extended_metadata")
              fault_domain                        = lookup(launch.value, "fault_domain")
              freeform_tags                       = merge(var.freeform_tags, lookup(launch.value, "freeform_tags"))
              ipxe_script                         = lookup(launch.value, "ipxe_script")
              is_pv_encryption_in_transit_enabled = lookup(launch.value, "is_pv_encryption_in_transit_enabled")
              launch_mode                         = lookup(launch.value, "launch_mode")
              metadata                            = lookup(launch.value, "metadata")
              preferred_maintenance_action        = lookup(launch.value, "preferred_maintenance_action")
              shape                               = lookup(launch.value, "shape")

              dynamic "agent_config" {
                for_each = try(lookup(launch.value, "agent_config") == null ? [] : ["agent_config"])
                iterator = agent
                content {
                  are_all_plugins_disabled = lookup(agent.value, "are_all_plugins_disabled")
                  is_management_disabled   = lookup(agent.value, "is_management_disabled")
                  is_monitoring_disabled   = lookup(agent.value, "is_monitoring_disabled")

                  dynamic "plugins_config" {
                    for_each = try(lookup(agent.value, "plugins_config") == null ? [] : ["plugins_config"])
                    content {
                      desired_state = lookup(plugins_config.value, "desired_state")
                      name          = lookup(plugins_config.value, "name")
                    }
                  }
                }
              }

              dynamic "availability_config" {
                for_each = try(lookup(launch.value, "availability_config") == null ? [] : ["availability_config"])
                iterator = availability
                content {
                  is_live_migration_preferred = lookup(availability.value, "is_live_migration_preferred")
                  recovery_action             = lookup(availability.value, "recovery_action")
                }
              }

              dynamic "create_vnic_details" {
                for_each = try(lookup(launch.value, "create_vnic_details") == null ? [] : ["create_vnic_details"])
                iterator = vnic
                content {
                  assign_ipv6ip             = lookup(vnic.value, "assign_ipv6ip")
                  assign_private_dns_record = lookup(vnic.value, "assign_private_dns_record")
                  assign_public_ip          = lookup(vnic.value, "assign_public_ip")
                  defined_tags              = merge(var.defined_tags, lookup(vnic.value, "defined_tags"))
                  display_name              = lookup(vnic.value, "display_name")
                  freeform_tags             = merge(var.freeform_tags, lookup(vnic.value, "freeform_tags"))
                  hostname_label            = lookup(vnic.value, "hostname_label")
                  nsg_ids                   = lookup(vnic.value, "nsg_ids")
                  private_ip                = lookup(vnic.value, "private_ip")
                  skip_source_dest_check    = lookup(vnic.value, "skip_source_dest_check")
                  subnet_id                 = try(element(oci_core_subnet.this.*.id, lookup(vnic.value, "subnet_id")))
                  #vlan_id                   = try(element(oci_core_vlan.this.*.id, lookup(vnic.value, "vlan_id")))
                }
              }

              dynamic "instance_options" {
                for_each = try(lookup(launch.value, "instance_options") == null ? [] : ["instance_options"])
                iterator = instance
                content {
                  are_legacy_imds_endpoints_disabled = lookup(instance.value, "are_legacy_imds_endpoints_disabled")
                }
              }

              dynamic "launch_options" {
                for_each = try(lookup(launch.value, "launch_options") == null ? [] : ["launch_options"])
                iterator = launch
                content {
                  boot_volume_type                    = lookup(launch.value, "boot_volume_type")
                  firmware                            = lookup(launch.value, "firmware")
                  is_consistent_volume_naming_enabled = lookup(launch.value, "is_consistent_volume_naming_enabled")
                  is_pv_encryption_in_transit_enabled = lookup(launch.value, "is_pv_encryption_in_transit_enabled")
                  network_type                        = lookup(launch.value, "network_type")
                  remote_data_volume_type             = lookup(launch.value, "remote_data_volume_type")
                }
              }

              dynamic "launch_volume_attachments" {
                for_each = try(lookup(launch.value, "launch_volume_attachments") == null ? [] : ["launch_volume_attachments"])
                iterator = volume
                content {
                  type                              = lookup(volume.value, "type")
                  device                            = lookup(volume.value, "device")
                  display_name                      = lookup(volume.value, "display_name")
                  encryption_in_transit_type        = lookup(volume.value, "encryption_in_transit_type")
                  is_agent_auto_iscsi_login_enabled = lookup(volume.value, "is_agent_auto_iscsi_login_enabled")
                  is_read_only                      = lookup(volume.value, "is_read_only")
                  is_shareable                      = lookup(volume.value, "is_shareable")
                  use_chap                          = lookup(volume.value, "use_chap")
                  volume_id                         = try(element(oci_core_boot_volume.this.*.id, lookup(volume.value, "volume_id")))

                  dynamic "launch_create_volume_details" {
                    for_each = try(lookup(volume.value, "launch_create_volume_details") == null ? [] : ["launch_create_volume_details"])
                    iterator = details
                    content {
                      size_in_gbs          = lookup(details.value, "size_in_gbs")
                      volume_creation_type = lookup(details.value, "volume_creation_type")
                      compartment_id       = try(element(module.identity.*.compartment_id, lookup(details.value, "compartment_id")))
                      display_name         = lookup(details.value, "display_name")
                      kms_key_id           = try(element(module.kms.*.key_id, lookup(details.value, "kms_key_id")))
                      vpus_per_gb          = lookup(details.value, "vpus_per_gb")
                    }
                  }
                }
              }

              dynamic "platform_config" {
                for_each = try(lookup(launch.value, "platform_config") == null ? [] : ["platform_config"])
                iterator = platform
                content {
                  type                             = lookup(platform.value, "type")
                  are_virtual_instructions_enabled = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" ? lookup(platform.value, "are_virtual_instructions_enabled") : null
                  #config_map                                     = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "config_map") : null
                  is_access_control_service_enabled              = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" ? lookup(platform.value, "is_access_control_service_enabled") : null
                  is_input_output_memory_management_unit_enabled = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "is_input_output_memory_management_unit_enabled") : null
                  is_measured_boot_enabled                       = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" || lookup(platform.value, "type") == "INTEL_VM" ? lookup(platform.value, "is_measured_boot_enabled") : null
                  is_memory_encryption_enabled                   = lookup(platform.value, "is_memory_encryption_enabled")
                  is_secure_boot_enabled                         = lookup(platform.value, "is_secure_boot_enabled")
                  is_symmetric_multi_threading_enabled           = lookup(platform.value, "is_symmetric_multi_threading_enabled")
                  is_trusted_platform_module_enabled             = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_MILAN_BM_GPU" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "is_trusted_platform_module_enabled") : null
                  numa_nodes_per_socket                          = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "AMD_ROME_BM_GPU" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "numa_nodes_per_socket") : null
                  percentage_of_cores_enabled                    = lookup(platform.value, "type") == "AMD_MILAN_BM" || lookup(platform.value, "type") == "AMD_ROME_BM" || lookup(platform.value, "type") == "GENERIC_BM" || lookup(platform.value, "type") == "INTEL_ICELAKE_BM" || lookup(platform.value, "type") == "INTEL_SKYLAKE_BM" ? lookup(platform.value, "percentage_of_cores_enabled") : null
                }
              }

              dynamic "preemptible_instance_config" {
                for_each = try(lookup(launch.value, "preemptible_instance_config") == null ? [] : ["preemptible_instance_config"])
                iterator = preemptible
                content {
                  dynamic "preemption_action" {
                    for_each = lookup(preemptible.value, "preemption_action")
                    iterator = action
                    content {
                      type                 = lookup(action.value, "type")
                      preserve_boot_volume = lookup(action.value, "preserve_boot_volume")
                    }
                  }
                }
              }

              dynamic "shape_config" {
                for_each = try(lookup(launch.value, "shape_config") == null ? [] : ["shape_config"])
                iterator = shape
                content {
                  baseline_ocpu_utilization = lookup(shape.value, "baseline_ocpu_utilization")
                  memory_in_gbs             = lookup(shape.value, "memory_in_gbs")
                  nvmes                     = lookup(shape.value, "nvmes")
                  ocpus                     = lookup(shape.value, "ocpus")
                  vcpus                     = lookup(shape.value, "vcpus")
                }
              }

              dynamic "source_details" {
                for_each = try(lookup(launch.value, "source_details") == null ? [] : ["source_details"])
                iterator = source
                content {
                  source_type = lookup(source.value, "source_type")
                  #source_id                       = try(element(oci_core_image.this.*.id, lookup(source.value, "image_id")))
                  boot_volume_size_in_gbs = lookup(source.value, "boot_volume_size_in_gbs")
                  boot_volume_vpus_per_gb = lookup(source.value, "boot_volume_vpus_per_gb")
                  kms_key_id              = try(element(module.kms.*.key_id, lookup(source.value, "kms_key_id")))
                  #is_preserve_boot_volume_enabled = lookup(source.value, "is_preserve_boot_volume_enabled")

                  dynamic "instance_source_image_filter_details" {
                    for_each = try(lookup(source.value, "instance_source_image_filter_details") == null ? [] : ["instance_source_image_filter_details"])
                    iterator = filter
                    content {
                      compartment_id           = try(element(module.identity.*.compartment_id, lookup(filter.value, "compartment_id")))
                      defined_tags_filter      = lookup(filter.value, "defined_tags_filter")
                      operating_system         = lookup(filter.value, "operating_system")
                      operating_system_version = lookup(filter.value, "operating_system_version")
                    }
                  }
                }
              }
            }
          }

          dynamic "secondary_vnics" {
            for_each = try(lookup(instance_details.value, "secondary_vnics") == null ? [] : ["secondary_vnics"])
            iterator = vnics
            content {
              display_name = lookup(vnics.value, "display_name")
              nic_index    = lookup(vnics.value, "nic_index")

              dynamic "create_vnic_details" {
                for_each = try(lookup(vnics.value, "create_vnic_details") == null ? [] : ["create_vnic_details"])
                iterator = details
                content {
                  assign_ipv6ip             = lookup(details.value, "assign_ipv6ip")
                  assign_private_dns_record = lookup(details.value, "assign_private_dns_record")
                  assign_public_ip          = lookup(details.value, "assign_public_ip")
                  defined_tags              = merge(var.defined_tags, lookup(details.value, "defined_tags"))
                  display_name              = lookup(details.value, "display_name")
                  freeform_tags             = merge(var.freeform_tags, lookup(details.value, "freeform_tags"))
                  hostname_label            = lookup(details.value, "hostname_label")
                  nsg_ids                   = [try(element(oci_core_network_security_group.this.*.id, lookup(details.value, "nsg_ids")))]
                  private_ip                = lookup(details.value, "private_ip")
                  skip_source_dest_check    = lookup(details.value, "skip_source_dest_check")
                  subnet_id                 = try(element(oci_core_subnet.this.*.id, lookup(details.value, "subnet_id")))

                  dynamic "ipv6address_ipv6subnet_cidr_pair_details" {
                    for_each = try(lookup(details.value, "ipv6address_ipv6subnet_cidr_pair_details") == null ? [] : ["ipv6address_ipv6subnet_cidr_pair_details"])
                    iterator = ipv6
                    content {
                      ipv6subnet_cidr = lookup(ipv6.value, "ipv6subnet_cidr")
                      ipv6address     = lookup(ipv6.value, "ipv6address")
                    }
                  }
                }
              }
            }
          }
        }
      }

      dynamic "secondary_vnics" {
        for_each = try(lookup(instance_details.value, "secondary_vnics") == null ? [] : ["secondary_vnics"])
        iterator = vnics
        content {
          dynamic "create_vnic_details" {
            for_each = try(lookup(vnics.value, "create_vnic_details") == null ? [] : ["create_vnic_details"])
            iterator = details
            content {
              assign_ipv6ip             = lookup(details.value, "assign_ipv6ip")
              assign_private_dns_record = lookup(details.value, "assign_private_dns_record")
              assign_public_ip          = lookup(details.value, "assign_public_ip")
              defined_tags              = merge(var.defined_tags, lookup(details.value, "defined_tags"))
              display_name              = lookup(details.value, "display_name")
              freeform_tags             = merge(var.freeform_tags, lookup(details.value, "freeform_tags"))
              hostname_label            = lookup(details.value, "hostname_label")
              nsg_ids                   = [try(element(oci_core_network_security_group.this.*.id, lookup(details.value, "nsg_ids")))]
              private_ip                = lookup(details.value, "private_ip")
              skip_source_dest_check    = lookup(details.value, "skip_source_dest_check")
              subnet_id                 = try(element(oci_core_subnet.this.*.id, lookup(details.value, "subnet_id")))

              dynamic "ipv6address_ipv6subnet_cidr_pair_details" {
                for_each = try(lookup(details.value, "ipv6address_ipv6subnet_cidr_pair_details") == null ? [] : ["ipv6address_ipv6subnet_cidr_pair_details"])
                iterator = ipv6
                content {
                  ipv6subnet_cidr = lookup(ipv6.value, "ipv6subnet_cidr")
                  ipv6address     = lookup(ipv6.value, "ipv6address")
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "oci_core_instance_pool" "this" {
  count                           = (length(var.compartment) && length(var.instance_configuration)) == 0 ? 0 : length(var.instance_pool)
  compartment_id                  = try(element(module.identity.*.compartment_id, lookup(var.instance_pool[count.index], "compartment_id")))
  instance_configuration_id       = try(element(oci_core_instance_configuration.this.*.id, lookup(var.instance_pool[count.index], "instance_configuration_id")))
  size                            = lookup(var.instance_configuration[count.index], "size")
  defined_tags                    = merge(var.defined_tags, lookup(var.instance_pool[count.index], "defined_tags"))
  display_name                    = lookup(var.instance_pool[count.index], "display_name")
  freeform_tags                   = merge(var.freeform_tags, lookup(var.instance_pool[count.index], "freeform_tags"))
  instance_display_name_formatter = lookup(var.instance_pool[count.index], "instance_display_name_formatter")
  instance_hostname_formatter     = lookup(var.instance_pool[count.index], "instance_hostname_formatter")
  state                           = lookup(var.instance_pool[count.index], "state")

  dynamic "load_balancers" {
    for_each = try(lookup(var.instance_pool[count.index], "load_balancers") == null ? [] : ["load_balancers"])
    iterator = lb
    content {
      backend_set_name = ""
      load_balancer_id = ""
      port             = lookup(lb.value, "port")
      vnic_selection   = lookup(lb.value, "vnic_selection")
    }
  }

  dynamic "placement_configurations" {
    for_each = lookup(var.instance_pool[count.index], "placement_configurations")
    iterator = pc
    content {
      availability_domain = lookup(pc.value, "availability_domain")
      fault_domains       = lookup(pc.value, "fault_domains")
      primary_subnet_id   = try(element(oci_core_subnet.this.*.id, lookup(pc.value, "primary_subnet_id")))

      dynamic "primary_vnic_subnets" {
        for_each = try(lookup(pc.value, "primary_vnic_subnets") == null ? [] : ["primary_vnic_subnets"])
        iterator = primary
        content {
          subnet_id        = try(element(oci_core_subnet.this.*.id, lookup(primary.value, "subnet_id")))
          is_assign_ipv6ip = lookup(primary.value, "is_assign_ipv6ip")

          dynamic "ipv6address_ipv6subnet_cidr_pair_details" {
            for_each = try(lookup(primary.value, "ipv6address_ipv6subnet_cidr_pair_details") == null ? [] : ["ipv6address_ipv6subnet_cidr_pair_details"])
            iterator = ipv6address
            content {
              ipv6subnet_cidr = lookup(ipv6address.value, "ipv6subnet_cidr")
            }
          }
        }
      }

      dynamic "secondary_vnic_subnets" {
        for_each = try(lookup(pc.value, "secondary_vnic_subnets") == null ? [] : ["secondary_vnic_subnets"])
        iterator = secondary
        content {
          subnet_id    = try(element(oci_core_subnet.this.*.id, lookup(secondary.value, "subnet_id")))
          display_name = lookup(secondary.value, "display_name")

          dynamic "ipv6address_ipv6subnet_cidr_pair_details" {
            for_each = try(lookup(secondary.value, "ipv6address_ipv6subnet_cidr_pair_details") == null ? [] : ["ipv6address_ipv6subnet_cidr_pair_details"])
            iterator = ipv6address
            content {
              ipv6subnet_cidr = lookup(ipv6address.value, "ipv6subnet_cidr")
            }
          }
        }
      }
    }
  }
}

resource "oci_core_instance_pool_instance" "this" {
  count            = (length(var.instance) && length(var.instance_pool)) == 0 ? 0 : length(var.instance_pool_instance)
  instance_id      = try(element(oci_core_instance.this.*.id, lookup(var.instance_pool_instance[count.index], "instance_id")))
  instance_pool_id = try(element(oci_core_instance_pool.this.*.id, lookup(var.instance_pool_instance[count.index], "instance_pool_id")))
}

resource "oci_core_internet_gateway" "this" {
  count          = (length(var.compartment) && length(var.vcn)) == 0 ? 0 : length(var.internet_gateway)
  compartment_id = try(element(module.identity.*.compartment_id, lookup(var.internet_gateway[count.index], "compartment_id")))
  vcn_id         = try(element(oci_core_vcn.this.*.id, lookup(var.internet_gateway[count.index], "vcn_id")))
  defined_tags   = merge(var.defined_tags, lookup(var.internet_gateway[count.index], "defined_tags"))
  display_name   = lookup(var.internet_gateway[count.index], "display_name")
  enabled        = lookup(var.internet_gateway[count.index], "enabled")
  freeform_tags  = merge(var.freeform_tags, lookup(var.internet_gateway[count.index], "freeform_tags"))
  route_table_id = try(element(oci_core_route_table.this.*.id, lookup(var.internet_gateway[count.index], "route_table_id")))
}

resource "oci_core_ipsec" "this" {
  count                     = (length(var.compartment) && length(var.cpe) && length(var.drg)) == 0 ? 0 : length(var.ipsec)
  compartment_id            = try(element(module.identity.*.compartment_id, lookup(var.ipsec[count.index], "compartment_id")))
  cpe_id                    = try(element(oci_core_cpe.this.*.id, lookup(var.ipsec[count.index], "cpe_id")))
  drg_id                    = try(element(oci_core_drg.this.*.id, lookup(var.ipsec[count.index], "drg_id")))
  static_routes             = lookup(var.ipsec[count.index], "static_routes")
  cpe_local_identifier      = lookup(var.ipsec[count.index], "cpe_local_identifier")
  cpe_local_identifier_type = lookup(var.ipsec[count.index], "cpe_local_identifier_type")
  defined_tags              = merge(var.defined_tags, lookup(var.ipsec[count.index], "defined_tags"))
  display_name              = lookup(var.ipsec[count.index], "display_name")
  freeform_tags             = merge(var.freeform_tags, lookup(var.ipsec[count.index], "freeform_tags"))
}

resource "oci_core_ipsec_connection_tunnel_management" "this" {
  count                   = (length(var.ipsec) && length(var.ipsec_connection_tunnels) && length(var.ipsec_connection_tunnel)) == 0 ? 0 : length(var.ipsec_connection_tunnel_management)
  ipsec_id                = try(element(oci_core_ipsec.this.*.id, lookup(var.ipsec_connection_tunnel_management[count.index], "ipsec_id")))
  tunnel_id               = try(element(data.oci_core_ipsec_connection_tunnels.this.*.ip_sec_connection_tunnels[0].id, lookup(var.ipsec_connection_tunnel_management[count.index], "tunnel_id")))
  display_name            = lookup(var.ipsec_connection_tunnel_management[count.index], "display_name")
  shared_secret           = lookup(var.ipsec_connection_tunnel_management[count.index], "shared_secret")
  ike_version             = lookup(var.ipsec_connection_tunnel_management[count.index], "ike_version")
  routing                 = lookup(var.ipsec_connection_tunnel_management[count.index], "routing")
  nat_translation_enabled = lookup(var.ipsec_connection_tunnel_management[count.index], "nat_translation_enabled")
  oracle_can_initiate     = lookup(var.ipsec_connection_tunnel_management[count.index], "oracle_can_initiate")


  dynamic "bgp_session_info" {
    for_each = try(lookup(var.ipsec_connection_tunnel_management[count.index], "bgp_session_info") == null ? [] : ["bgp_session_info"])
    iterator = bgp
    content {
      customer_bgp_asn        = lookup(bgp.value, "customer_bgp_asn")
      customer_interface_ip   = lookup(bgp.value, "customer_interface_ip")
      customer_interface_ipv6 = lookup(bgp.value, "customer_interface_ipv6")
      oracle_interface_ip     = lookup(bgp.value, "oracle_interface_ip")
      oracle_interface_ipv6   = lookup(bgp.value, "oracle_interface_ipv6")
    }
  }

  dynamic "dpd_config" {
    for_each = try(lookup(var.ipsec_connection_tunnel_management[count.index], "dpd_config") == null ? [] : ["dpd_config"])
    iterator = dpd
    content {
      dpd_mode           = lookup(dpd.value, "dpd_mode")
      dpd_timeout_in_sec = lookup(dpd.value, "dpd_timeout_in_sec")
    }
  }

  dynamic "encryption_domain_config" {
    for_each = try(lookup(var.ipsec_connection_tunnel_management[count.index], "encryption_domain_config") == null ? [] : ["encryption_domain_config"])
    iterator = encryption
    content {
      cpe_traffic_selector    = lookup(encryption.value, "cpe_traffic_selector")
      oracle_traffic_selector = lookup(encryption.value, "oracle_traffic_selector")
    }
  }

  dynamic "phase_one_details" {
    for_each = try(lookup(var.ipsec_connection_tunnel_management[count.index], "phase_one_details") == null ? [] : ["phase_one_details"])
    iterator = one
    content {
      custom_authentication_algorithm = lookup(one.value, "custom_authentication_algorithm")
      custom_dh_group                 = lookup(one.value, "custom_dh_group")
      custom_encryption_algorithm     = lookup(one.value, "custom_encryption_algorithm")
      is_custom_phase_one_config      = lookup(one.value, "is_custom_phase_one_config")
      lifetime                        = lookup(one.value, "lifetime")
    }
  }

  dynamic "phase_two_details" {
    for_each = try(lookup(var.ipsec_connection_tunnel_management[count.index], "phase_two_details") == null ? [] : ["phase_two_details"])
    iterator = two
    content {
      custom_authentication_algorithm = lookup(two.value, "custom_authentication_algorithm")
      custom_encryption_algorithm     = lookup(two.value, "custom_encryption_algorithm")
      dh_group                        = lookup(two.value, "dh_group")
      is_custom_phase_two_config      = lookup(two.value, "is_custom_phase_two_config")
      is_pfs_enabled                  = lookup(two.value, "is_pfs_enabled")
      lifetime                        = lookup(two.value, "lifetime")
    }
  }
}

resource "oci_core_ipv6" "this" {
  count           = length(var.vnic_attachment) == 0 ? 0 : length(var.ipv6)
  vnic_id         = try(element(oci_core_vnic_attachment.this.*.id, lookup(var.ipv6[count.index], "vnic_id")))
  defined_tags    = merge(var.defined_tags, lookup(var.ipv6[count.index], "defined_tags"))
  display_name    = lookup(var.ipv6[count.index], "display_name")
  freeform_tags   = merge(var.freeform_tags, lookup(var.ipv6[count.index], "freeform_tags"))
  ip_address      = lookup(var.ipv6[count.index], "ip_address")
  ipv6subnet_cidr = lookup(var.ipv6[count.index], "ipv6subnet_cidr")
}

resource "oci_core_local_peering_gateway" "this" {
  count          = (length(var.compartment) && length(var.vcn)) == 0 ? 0 : length(var.local_peering_gateway)
  compartment_id = try(element(module.identity.*.compartment_id, lookup(var.local_peering_gateway[count.index], "compartment_id")))
  vcn_id         = try(element(oci_core_vcn.this.*.id, lookup(var.local_peering_gateway[count.index], "vcn_id")))
  defined_tags   = merge(var.defined_tags, lookup(var.local_peering_gateway[count.index], "defined_tags"))
  display_name   = lookup(var.local_peering_gateway[count.index], "display_name")
  freeform_tags  = merge(var.freeform_tags, lookup(var.local_peering_gateway[count.index], "freeform_tags"))
  peer_id        = try(element(oci_core_local_peering_gateway.this.*.id, lookup(var.local_peering_gateway[count.index], "peer_id")))
  route_table_id = try(element(oci_core_route_table.this.*.id, lookup(var.local_peering_gateway[count.index], "route_table_id")))
}

resource "oci_core_nat_gateway" "this" {
  count          = (length(var.compartment) && length(var.vcn)) == 0 ? 0 : length(var.nat_gateway)
  compartment_id = try(element(module.identity.*.compartment_id, lookup(var.nat_gateway[count.index], "compartment_id")))
  vcn_id         = try(element(oci_core_vcn.this.*.id, lookup(var.nat_gateway[count.index], "vcn_id")))
  block_traffic  = lookup(var.nat_gateway[count.index], "block_traffic")
  defined_tags   = merge(var.defined_tags, lookup(var.nat_gateway[count.index], "defined_tags"))
  display_name   = lookup(var.nat_gateway[count.index], "display_name")
  freeform_tags  = merge(var.freeform_tags, lookup(var.nat_gateway[count.index], "freeform_tags"))
  public_ip_id   = try(element(oci_core_public_ip.this.*.id, lookup(var.nat_gateway[count.index], "public_ip_id")))
  route_table_id = try(element(oci_core_route_table.this.*.id, lookup(var.nat_gateway[count.index], "route_table_id")))
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

resource "oci_core_volume" "this" {
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