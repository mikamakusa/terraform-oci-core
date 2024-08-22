## TAGS ##

variable "defined_tags" {
  type    = map(string)
  default = {}
}

variable "freeform_tags" {
  type    = map(string)
  default = {}
}

## MODULES ##

variable "compartment" {
  type = any
}

## RESOURCES ##

variable "app_catalog_listing_resource_version_agreement" {
  type = list(object({
    id                       = number
    listing_id               = any
    listing_resource_version = string
  }))
  default = []
}

variable "app_catalog_subscription" {
  type = list(object({
    id                       = number
    compartment_id           = any
    listing_id               = any
    listing_resource_version = string
    oracle_terms_of_use_link = string
    signature                = string
    time_retrieved           = string
    eula_link                = optional(string)
  }))
  default = []
}

variable "boot_volume" {
  type = list(object({
    id                            = number
    availability_domain           = string
    compartment_id                = any
    cluster_placement_group_id    = optional(any)
    defined_tags                  = optional(map(string))
    display_name                  = optional(string)
    freeform_tags                 = optional(map(string))
    is_auto_tune_enabled          = optional(bool)
    kms_key_id                    = optional(any)
    size_in_gbs                   = optional(string)
    vpus_per_gb                   = optional(string)
    boot_volume_replicas_deletion = optional(bool)
    source_details = list(object({
      id   = string
      type = string
    }))
    autotune_policies = optional(list(object({
      autotune_type   = string
      max_vpus_per_gb = optional(string)
    })))
    boot_volume_replicas = optional(list(object({
      availability_domain = string
      display_name        = optional(string)
    })))
  }))
  default = []
}

variable "boot_volume_backup" {
  type = list(object({
    id             = number
    boot_volume_id = any
    defined_tags   = optional(map(string))
    display_name   = optional(string)
    freeform_tags  = optional(map(string))
    kms_key_id     = optional(any)
    type           = optional(string)
    source_details = optional(list(object({
      boot_volume_backup_id = any
      region                = string
      kms_key_id            = optional(any)
    })))
  }))
  default = []

  validation {
    condition = length([
      for a in var.boot_volume_backup : true if contains(["FULL", "INCREMENTAL"], a.type)
    ]) == length(var.boot_volume_backup)
    error_message = "The type of backup to create. If omitted, defaults to incremental. Supported values are 'FULL' or 'INCREMENTAL'."
  }
}

variable "capture_filter" {
  type = list(object({
    id             = number
    compartment_id = any
    filter_type    = string
    defined_tags   = optional(map(string))
    display_name   = optional(string)
    freeform_tags  = optional(map(string))
    flow_log_capture_filter_rules = optional(list(object({
      destination_cidr = optional(string)
      flow_log_type    = optional(string)
      is_enabled       = optional(bool)
      priority         = optional(number)
      protocol         = optional(string)
      rule_action      = optional(string)
      sampling_rate    = optional(number)
      source_cidr      = optional(string)
      icmp_options = optional(list(object({
        type = number
        code = optional(number)
      })))
      tcp_options = optional(list(object({
        destination_port_range = optional(list(object({
          max = number
          min = number
        })))
        source_port_range = optional(list(object({
          max = number
          min = number
        })))
      })))
      udp_options = optional(list(object({
        destination_port_range = optional(list(object({
          max = number
          min = number
        })))
        source_port_range = optional(list(object({
          max = number
          min = number
        })))
      })))
    })))
    vtap_capture_filter_rules = optional(list(object({
      traffic_direction = string
      destination_cidr  = optional(string)
      protocol          = optional(string)
      rule_action       = optional(string)
      source_cidr       = optional(string)
      icmp_options = optional(list(object({
        type = number
        code = optional(number)
      })))
      tcp_options = optional(list(object({
        destination_port_range = optional(list(object({
          max = number
          min = number
        })))
        source_port_range = optional(list(object({
          max = number
          min = number
        })))
      })))
      udp_options = optional(list(object({
        destination_port_range = optional(list(object({
          max = number
          min = number
        })))
        source_port_range = optional(list(object({
          max = number
          min = number
        })))
      })))
    })))
  }))
  default = []

  validation {
    condition = length([
      for a in var.capture_filter : true if a.flow_log_capture_filter_rules.priority >= 0 && a.flow_log_capture_filter_rules.priority <= 9
    ]) == length(var.capture_filter)
    error_message = "A lower number indicates a higher priority, range 0-9. Each rule must have a distinct priority."
  }

  validation {
    condition = length([
      for b in var.capture_filter : true if b.flow_log_capture_filter_rules.sampling_rate >= 1 && b.flow_log_capture_filter_rules.sampling_rate <= 10000
    ]) == length(var.capture_filter)
    error_message = "Sampling interval as 1 of X, where X is an integer not greater than 100000."
  }
}

variable "cluster_network" {
  type = list(object({
    id             = number
    compartment_id = any
    defined_tags   = optional(map(string))
    display_name   = optional(string)
    freeform_tags  = optional(map(string))
    instance_pools = list(object({
      instance_configuration_id = any
      size                      = number
      defined_tags              = optional(map(string))
      freeform_tags             = optional(map(string))
      display_name              = optional(string)
    }))
    placement_configuration = list(object({
      availability_domain = string
      primary_subnet_id   = optional(any)
      primary_vnic_subnets = optional(list(object({
        subnet_id        = any
        is_assign_ipv6ip = optional(bool)
        ipv6address_ipv6subnet_cidr_pair_details = optional(list(object({
          ipv6subnet_cidr = optional(string)
        })))
      })))
      secondary_vnic_subnets = optional(list(object({
        subnet_id        = any
        is_assign_ipv6ip = optional(bool)
        ipv6address_ipv6subnet_cidr_pair_details = optional(list(object({
          ipv6subnet_cidr = optional(string)
        })))
      })))
    }))
    cluster_configuration = optional(list(object({
      hpc_island_id     = any
      network_block_ids = optional(list(string))
    })))
  }))
  default = []
}

variable "compute_capacity_report" {
  type = list(object({
    id                  = number
    availability_domain = string
    compartment_id      = any
    shape_availabilities = list(object({
      instance_shape = string
      fault_domain   = optional(string)
      instance_shape_config = optional(list(object({
        memory_in_gbs = optional(number)
        nvmes         = optional(number)
        ocpus         = optional(number)
      })))
    }))
  }))
  default = []
}

variable "compute_capacity_reservation" {
  type = list(object({
    id                     = number
    availability_domain    = string
    compartment_id         = any
    defined_tags           = optional(map(string))
    display_name           = optional(string)
    freeform_tags          = optional(map(string))
    is_default_reservation = optional(bool)
    instance_reservation_configs = list(object({
      reserved_count             = string
      instance_shape             = string
      cluster_placement_group_id = optional(any)
      fault_domain               = optional(string)
      cluster_config = optional(list(object({
        hpc_island_id     = any
        network_block_ids = optional(list(string))
      })))
      instance_shape_config = optional(list(object({
        memory_in_gbs = optional(number)
        ocpus         = optional(number)
      })))
    }))
  }))
  default = []
}

variable "compute_capacity_topology" {
  type = list(object({
    id                  = number
    availability_domain = string
    compartment_id      = any
    display_name        = optional(string)
    defined_tags        = optional(map(string))
    freeform_tags       = optional(map(string))
    capacity_source = list(object({
      capacity_type  = string
      compartment_id = optional(any)
    }))
  }))
  default = []
}

variable "compute_cluster" {
  type = list(object({
    id                  = number
    availability_domain = string
    compartment_id      = any
    display_name        = optional(string)
    defined_tags        = optional(map(string))
    freeform_tags       = optional(map(string))
  }))
  default = []
}

variable "compute_image_capability_schema" {
  type = list(object({
    id                                                  = number
    compartment_id                                      = any
    compute_global_image_capability_schema_version_name = string
    image_id                                            = any
    schema_data                                         = map(any)
    display_name                                        = optional(string)
    defined_tags                                        = optional(map(string))
    freeform_tags                                       = optional(map(string))
  }))
  default = []
}

variable "console_history" {
  type = list(object({
    id            = number
    instance_id   = any
    display_name  = optional(string)
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
  }))
  default = []
}

variable "cpe" {
  type = list(object({
    id                  = number
    compartment_id      = any
    ip_address          = string
    cpe_device_shape_id = optional(any)
    defined_tags        = optional(map(string))
    display_name        = optional(string)
    freeform_tags       = optional(map(string))
    is_private          = optional(bool)
  }))
  default = []
}

variable "cross_connect" {
  type = list(object({
    id                                           = number
    compartment_id                               = any
    location_name                                = string
    port_speed_shape_name                        = string
    cross_connect_group_id                       = optional(any)
    customer_reference_name                      = optional(string)
    defined_tags                                 = optional(map(string))
    display_name                                 = optional(string)
    far_cross_connect_or_cross_connect_group_id  = optional(any)
    freeform_tags                                = optional(map(string))
    near_cross_connect_or_cross_connect_group_id = optional(any)
    macsec_properties = optional(list(object({
      state                          = string
      encryption_cipher              = optional(string)
      is_unprotected_traffic_allowed = optional(bool)
      primary_key = optional(list(object({
        connectivity_association_key_secret_id  = optional(any)
        connectivity_association_name_secret_id = optional(any)
      })))
    })))
  }))
  default = []
}

variable "cross_connect_group" {
  type = list(object({
    id                      = number
    compartment_id          = any
    customer_reference_name = optional(string)
    defined_tags            = optional(map(string))
    display_name            = optional(string)
    freeform_tags           = optional(map(string))
    macsec_properties = optional(list(object({
      state                          = string
      encryption_cipher              = optional(string)
      is_unprotected_traffic_allowed = optional(bool)
      primary_key = optional(list(object({
        connectivity_association_key_secret_id  = optional(any)
        connectivity_association_name_secret_id = optional(any)
      })))
    })))
  }))
  default = []
}

variable "dedicated_vm_host" {
  type = list(object({
    id                      = number
    availability_domain     = string
    compartment_id          = any
    dedicated_vm_host_shape = string
    defined_tags            = optional(map(string))
    display_name            = optional(string)
    fault_domain            = optional(string)
    freeform_tags           = optional(map(string))
  }))
  default = []
}

variable "dhcp_options" {
  type = list(object({
    id               = number
    compartment_id   = any
    vcn_id           = any
    defined_tags     = optional(map(string))
    display_name     = optional(string)
    domain_name_type = optional(string)
    freeform_tags    = optional(map(string))
    options = list(object({
      type                = string
      custom_dns_servers  = optional(list(string))
      search_domain_names = optional(list(string))
      server_type         = optional(string)
    }))
  }))
  default = []
}

variable "drg" {
  type = list(object({
    id             = number
    compartment_id = any
    defined_tags   = optional(map(string))
    display_name   = optional(string)
    freeform_tags  = optional(map(string))
  }))
  default = []
}

variable "drg_attachment" {
  type = list(object({
    id                 = number
    drg_id             = any
    defined_tags       = optional(map(string))
    display_name       = optional(string)
    drg_route_table_id = optional(any)
    freeform_tags      = optional(map(string))
    network_details = optional(list(object({
      type           = string
      id             = optional(any)
      route_table_id = optional(any)
      vcn_route_type = optional(string)
    })))
  }))
  default = []
}

variable "drg_attachment_management" {
  type = list(object({
    id                                           = number
    attachment_type                              = string
    compartment_id                               = any
    drg_id                                       = any
    defined_tags                                 = optional(map(string))
    display_name                                 = optional(string)
    drg_route_table_id                           = optional(any)
    export_drg_route_distribution_id             = optional(any)
    freeform_tags                                = optional(map(string))
    network_id                                   = optional(any)
    remove_export_drg_route_distribution_trigger = optional(bool)
    route_table_id                               = optional(any)
    vcn_id                                       = optional(any)
    network_details = optional(list(object({
      type                = string
      id                  = any
      route_table_id      = optional(any)
      ipsec_connection_id = optional(any)
    })))
  }))
  default = []

  validation {
    condition = length([
      for a in var.drg_attachment_management : true if contains(["IPSEC_TUNNEL", "REMOTE_PEERING_CONNECTION", "VCN", "VIRTUAL_CIRCUIT"], a.network_details.type)
    ]) == length(var.drg_attachment_management)
    error_message = "The type can be one of these values: IPSEC_TUNNEL, REMOTE_PEERING_CONNECTION, VCN,VIRTUAL_CIRCUIT."
  }
}

variable "drg_attachments_list" {
  type = list(object({
    id               = number
    drg_id           = any
    attachment_type  = optional(string)
    is_cross_tenancy = optional(bool)
  }))
  default = []
}

variable "drg_route_distribution" {
  type = list(object({
    id                = number
    distribution_type = string
    drg_id            = any
    defined_tags      = optional(map(string))
    display_name      = optional(string)
    freeform_tags     = optional(map(string))
  }))
  default = []
}

variable "drg_route_distribution_statement" {
  type = list(object({
    id                        = number
    action                    = string
    drg_route_distribution_id = any
    priority                  = number
    match_criteria = list(object({
      match_type        = string
      attachment_type   = optional(string)
      drg_attachment_id = optional(any)
    }))
  }))
  default = []

  validation {
    condition = length([
      for a in var.drg_route_distribution_statement : true if contains(["MATCH_ALL", "DRG_ATTACHMENT_TYPE", "DRG_ATTACHMENT_ID"], a.match_criteria.match_type)
    ]) == length(var.drg_route_distribution_statement)
    error_message = "Possible values are : MATCH_ALL, DRG_ATTACHMENT_TYPE, DRG_ATTACHMENT_ID."
  }
}

variable "drg_route_table" {
  type = list(object({
    id                               = number
    drg_id                           = any
    defined_tags                     = optional(map(string))
    display_name                     = optional(string)
    freeform_tags                    = optional(map(string))
    import_drg_route_distribution_id = optional(any)
    is_ecmp_enabled                  = optional(bool)
    remove_import_trigger            = optional(bool)
  }))
  default = []
}

variable "drg_route_table_route_rule" {
  type = list(object({
    id                         = number
    destination                = string
    destination_type           = string
    drg_route_table_id         = any
    next_hop_drg_attachment_id = any
  }))
  default = []
}

variable "image" {
  type = list(object({
    id            = number
    defined_tags  = optional(map(string))
    display_name  = optional(string)
    freeform_tags = optional(map(string))
    instance_id   = optional(any)
    launch_mode   = optional(string)
    image_source_details = optional(list(object({
      source_type              = string
      namespace_name           = optional(string)
      object_name              = optional(string)
      operating_system         = optional(string)
      operating_system_version = optional(string)
      source_image_type        = optional(string)
      source_uri               = optional(string)
    })))
  }))
  default = []

  validation {
    condition = length([
      for a in var.image : true if contains(["NATIVE", "EMULATED", "PARAVIRTUALIZED", "CUSTOM"], a.launch_mode)
    ]) == length(var.image)
    error_message = "Possible values : NATIVE, EMULATED, PARAVIRTUALIZED, CUSTOM."
  }

  validation {
    condition = length([
      for b in var.image : true if contains(["VMDK", "QCOW2"], b.image_source_details.image_source_type)
    ]) == length(var.image)
    error_message = "Possible values : VMDK, QCOW2."
  }
}

variable "instance" {
  type = list(object({
    id                                      = number
    availability_domain                     = string
    compartment_id                          = any
    shape                                   = string
    async                                   = optional(bool)
    capacity_reservation_id                 = optional(any)
    cluster_placement_group_id              = optional(any)
    compute_cluster_id                      = optional(any)
    dedicated_vm_host_id                    = optional(any)
    defined_tags                            = optional(map(string))
    display_name                            = optional(string)
    extended_metadata                       = optional(map(string))
    fault_domain                            = optional(string)
    freeform_tags                           = optional(map(string))
    instance_configuration_id               = optional(any)
    ipxe_script                             = optional(string)
    is_pv_encryption_in_transit_enabled     = optional(bool)
    metadata                                = optional(map(string))
    preserve_boot_volume                    = optional(bool)
    preserve_data_volumes_created_at_launch = optional(bool)
    state                                   = optional(string)
    update_operation_constraint             = optional(string)
    agent_config = optional(list(object({
      are_all_plugins_disabled = optional(bool)
      is_management_disabled   = optional(bool)
      is_monitoring_disabled   = optional(bool)
      plugins_config = optional(list(object({
        desired_state = string
        name          = string
      })))
    })))
    availability_config = optional(list(object({
      is_live_migration_preferred = optional(bool)
      recovery_action             = optional(string)
    })))
    create_vnic_details = optional(list(object({
      assign_ipv6ip             = optional(bool)
      assign_private_dns_record = optional(bool)
      assign_public_ip          = optional(string)
      defined_tags              = optional(map(string))
      display_name              = optional(string)
      freeform_tags             = optional(map(string))
      hostname_label            = optional(string)
      nsg_ids                   = optional(list(string))
      private_ip                = optional(string)
      skip_source_dest_check    = optional(bool)
      subnet_id                 = optional(any)
      vlan_id                   = optional(any)
    })))
    instance_options = optional(list(object({
      are_legacy_imds_endpoints_disabled = optional(bool)
    })))
    launch_options = optional(list(object({
      boot_volume_type                    = optional(string)
      firmware                            = optional(string)
      is_consistent_volume_naming_enabled = optional(bool)
      is_pv_encryption_in_transit_enabled = optional(bool)
      network_type                        = optional(string)
      remote_data_volume_type             = optional(string)
    })))
    launch_volume_attachments = optional(list(object({
      type                              = string
      device                            = optional(string)
      display_name                      = optional(string)
      encryption_in_transit_type        = optional(string)
      is_agent_auto_iscsi_login_enabled = optional(bool)
      is_read_only                      = optional(bool)
      is_shareable                      = optional(bool)
      use_chap                          = optional(bool)
      volume_id                         = optional(string)
      launch_create_volume_details = optional(list(object({
        size_in_gbs          = optional(string)
        volume_creation_type = optional(string)
        compartment_id       = optional(any)
        display_name         = optional(string)
        kms_key_id           = optional(any)
        vpus_per_gb          = optional(string)
      })))
    })))
    platform_config = optional(list(object({
      type                                           = string
      are_virtual_instructions_enabled               = optional(bool)
      config_map                                     = optional(map(string))
      is_access_control_service_enabled              = optional(bool)
      is_input_output_memory_management_unit_enabled = optional(bool)
      is_measured_boot_enabled                       = optional(bool)
      is_memory_encryption_enabled                   = optional(bool)
      is_secure_boot_enabled                         = optional(bool)
      is_symmetric_multi_threading_enabled           = optional(bool)
      is_trusted_platform_module_enabled             = optional(bool)
      numa_nodes_per_socket                          = optional(string)
      percentage_of_cores_enabled                    = optional(number)
    })))
    preemptible_instance_config = optional(list(object({
      preemption_action = list(object({
        type                 = string
        preserve_boot_volume = optional(bool)
      }))
    })))
    shape_config = optional(list(object({
      baseline_ocpu_utilization = optional(string)
      memory_in_gbs             = optional(number)
      nvmes                     = optional(number)
      ocpus                     = optional(number)
      vcpus                     = optional(number)
    })))
    source_details = optional(list(object({
      source_type                     = string
      source_type                     = optional(string)
      source_id                       = optional(string)
      boot_volume_size_in_gbs         = optional(string)
      boot_volume_vpus_per_gb         = optional(string)
      kms_key_id                      = optional(string)
      is_preserve_boot_volume_enabled = optional(bool)
      instance_source_image_filter_details = optional(list(object({
        compartment_id           = any
        defined_tags_filter      = optional(map(string))
        operating_system         = optional(string)
        operating_system_version = optional(string)
      })))
    })))
  }))
  default = []

  validation {
    condition = length([
      for a in var.instance : true if contains(["RESTORE_INSTANCE", "STOP_INSTANCE"], a.availability_config.recovery_action)
    ]) == length(var.instance)
    error_message = "Possible values are RESTORE_INSTANCE and STOP_INSTANCE."
  }

  validation {
    condition = length([
      for b in var.instance : true if contains(["ISCSI", "SCSI", "IDE", "VFIO", "PARAVIRTUALIZED"], b.launch_options.boot_volume_type)
    ]) == length(var.instance)
    error_message = "Possible values are ISCSI, SCSI, IDE, VFIO and PARAVIRTUALIZED."
  }

  validation {
    condition = length([
      for c in var.instance : true if contains(["BIOS", "UEFI_64"], c.launch_options.firmware)
    ]) == length(var.instance)
    error_message = "Possible values are BIOS, UEFI_64."
  }

  validation {
    condition = length([
      for d in var.instance : true if contains(["E1000", "VFIO", "PARAVIRTUALIZED"], d.launch_options.network_type)
    ]) == length(var.instance)
    error_message = "Possible values are E1000, VFIO and PARAVIRTUALIZED."
  }

  validation {
    condition = length([
      for e in var.instance : true if contains(["ISCSI", "SCSI", "IDE", "VFIO", "PARAVIRTUALIZED"], e.launch_options.remote_data_volume_type)
    ]) == length(var.instance)
    error_message = "Possible values are ISCSI, SCSI, IDE, VFIO and PARAVIRTUALIZED."
  }

  validation {
    condition = length([
      for f in var.instance : true if contains(["0", "10", "20", "30"], f.launch_volume_attachments.lauch_create_volume_details.vpus_per_gb)
    ]) == length(var.instance)
    error_message = "Possible values are 0, 10, 20, 30."
  }

  validation {
    condition = length([
      for g in var.instance : true if contains(["BASELINE_1_8", "BASELINE_1_2", "BASELINE_1_1"], g.shape_config.baseline_ocpu_utilization)
    ]) == length(var.instance)
    error_message = "Possible values are BASELINE_1_8, BASELINE_1_2, BASELINE_1_1."
  }

  validation {
    condition = length([
      for g in var.instance : true if contains(["10", "20", "30"], g.source_details.boot_volume_vpus_per_gb)
    ]) == length(var.instance)
    error_message = "Possible values are 10, 20, 30."
  }
}

variable "instance_console_connection" {
  type = list(object({
    id            = number
    instance_id   = any
    public_key    = string
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
  }))
  default = []
}

variable "instance_configuration" {
  type = list(object({
    id             = number
    compartment_id = any
    defined_tags   = optional(map(string))
    display_name   = optional(string)
    freeform_tags  = optional(map(string))
    instance_id    = any
    source         = optional(string)
    instance_details = optional(list(object({
      instance_type = string
      block_volumes = optional(list(object({
        attach_details = optional(list(object({
          type                                = string
          device                              = optional(string)
          display_name                        = optional(string)
          is_pv_encryption_in_transit_enabled = optional(bool)
          is_read_only                        = optional(bool)
          is_shareable                        = optional(bool)
          use_chap                            = optional(bool)
        })))
        create_details = optional(list(object({
          availability_domain        = optional(string)
          backup_policy_id           = optional(any)
          cluster_placement_group_id = optional(any)
          compartment_id             = optional(any)
          defined_tags               = optional(map(string))
          display_name               = optional(string)
          freeform_tags              = optional(map(string))
          is_auto_tune_enabled       = optional(bool)
          kms_key_id                 = optional(any)
          size_in_gbs                = optional(string)
          vpus_per_gb                = optional(string)
          autotune_policies = optional(list(object({
            autotune_type   = string
            max_vpus_per_gb = optional(string)
          })))
          block_volume_replicas = optional(list(object({
            availability_domain = string
            display_name        = optional(string)
          })))
          source_details = optional(list(object({
            type = string
          })))
        })))
      })))
      launch_details = optional(list(object({
        availability_domain                 = optional(string)
        capacity_reservation_id             = optional(any)
        cluster_placement_group_id          = optional(any)
        compartment_id                      = optional(any)
        dedicated_vm_host_id                = optional(any)
        defined_tags                        = optional(string)
        display_name                        = optional(string)
        extended_metadata                   = optional(map(string))
        fault_domain                        = optional(string)
        freeform_tags                       = optional(map(string))
        ipxe_script                         = optional(string)
        is_pv_encryption_in_transit_enabled = optional(bool)
        launch_mode                         = optional(string)
        metadata                            = optional(map(string))
        preferred_maintenance_action        = optional(string)
        shape                               = optional(string)
        agent_config = optional(list(object({
          are_all_plugins_disabled = optional(bool)
          is_management_disabled   = optional(bool)
          is_monitoring_disabled   = optional(bool)
          plugins_config = optional(list(object({
            desired_state = string
            name          = string
          })))
        })))
        availability_config = optional(list(object({
          is_live_migration_preferred = optional(bool)
          recovery_action             = optional(string)
        })))
        create_vnic_details = optional(list(object({
          assign_ipv6ip             = optional(bool)
          assign_private_dns_record = optional(bool)
          assign_public_ip          = optional(string)
          defined_tags              = optional(map(string))
          display_name              = optional(string)
          freeform_tags             = optional(map(string))
          hostname_label            = optional(string)
          nsg_ids                   = optional(list(string))
          private_ip                = optional(string)
          skip_source_dest_check    = optional(bool)
          subnet_id                 = optional(any)
          vlan_id                   = optional(any)
        })))
        instance_options = optional(list(object({
          are_legacy_imds_endpoints_disabled = optional(bool)
        })))
        launch_options = optional(list(object({
          boot_volume_type                    = optional(string)
          firmware                            = optional(string)
          is_consistent_volume_naming_enabled = optional(bool)
          is_pv_encryption_in_transit_enabled = optional(bool)
          network_type                        = optional(string)
          remote_data_volume_type             = optional(string)
        })))
        launch_volume_attachments = optional(list(object({
          type                              = string
          device                            = optional(string)
          display_name                      = optional(string)
          encryption_in_transit_type        = optional(string)
          is_agent_auto_iscsi_login_enabled = optional(bool)
          is_read_only                      = optional(bool)
          is_shareable                      = optional(bool)
          use_chap                          = optional(bool)
          volume_id                         = optional(string)
          launch_create_volume_details = optional(list(object({
            size_in_gbs          = optional(string)
            volume_creation_type = optional(string)
            compartment_id       = optional(any)
            display_name         = optional(string)
            kms_key_id           = optional(any)
            vpus_per_gb          = optional(string)
          })))
        })))
        platform_config = optional(list(object({
          type                                           = string
          are_virtual_instructions_enabled               = optional(bool)
          config_map                                     = optional(map(string))
          is_access_control_service_enabled              = optional(bool)
          is_input_output_memory_management_unit_enabled = optional(bool)
          is_measured_boot_enabled                       = optional(bool)
          is_memory_encryption_enabled                   = optional(bool)
          is_secure_boot_enabled                         = optional(bool)
          is_symmetric_multi_threading_enabled           = optional(bool)
          is_trusted_platform_module_enabled             = optional(bool)
          numa_nodes_per_socket                          = optional(string)
          percentage_of_cores_enabled                    = optional(number)
        })))
        preemptible_instance_config = optional(list(object({
          preemption_action = list(object({
            type                 = string
            preserve_boot_volume = optional(bool)
          }))
        })))
        shape_config = optional(list(object({
          baseline_ocpu_utilization = optional(string)
          memory_in_gbs             = optional(number)
          nvmes                     = optional(number)
          ocpus                     = optional(number)
          vcpus                     = optional(number)
        })))
        source_details = optional(list(object({
          source_type                     = string
          source_type                     = optional(string)
          source_id                       = optional(string)
          boot_volume_size_in_gbs         = optional(string)
          boot_volume_vpus_per_gb         = optional(string)
          kms_key_id                      = optional(string)
          is_preserve_boot_volume_enabled = optional(bool)
          instance_source_image_filter_details = optional(list(object({
            compartment_id           = any
            defined_tags_filter      = optional(map(string))
            operating_system         = optional(string)
            operating_system_version = optional(string)
          })))
        })))
      })))
      options = optional(list(object({
        block_volumes = optional(list(object({
          attach_details = optional(list(object({
            type                                = string
            device                              = optional(string)
            display_name                        = optional(string)
            is_pv_encryption_in_transit_enabled = optional(bool)
            is_read_only                        = optional(bool)
            is_shareable                        = optional(bool)
            use_chap                            = optional(bool)
          })))
          create_details = optional(list(object({
            availability_domain        = optional(string)
            backup_policy_id           = optional(any)
            cluster_placement_group_id = optional(any)
            compartment_id             = optional(any)
            defined_tags               = optional(map(string))
            display_name               = optional(string)
            freeform_tags              = optional(map(string))
            is_auto_tune_enabled       = optional(bool)
            kms_key_id                 = optional(any)
            size_in_gbs                = optional(string)
            vpus_per_gb                = optional(string)
            autotune_policies = optional(list(object({
              autotune_type   = string
              max_vpus_per_gb = optional(string)
            })))
            block_volume_replicas = optional(list(object({
              availability_domain = string
              display_name        = optional(string)
            })))
            source_details = optional(list(object({
              type = string
            })))
          })))
        })))
        launch_details = optional(list(object({
          availability_domain                 = optional(string)
          capacity_reservation_id             = optional(any)
          cluster_placement_group_id          = optional(any)
          compartment_id                      = optional(any)
          dedicated_vm_host_id                = optional(any)
          defined_tags                        = optional(string)
          display_name                        = optional(string)
          extended_metadata                   = optional(map(string))
          fault_domain                        = optional(string)
          freeform_tags                       = optional(map(string))
          ipxe_script                         = optional(string)
          is_pv_encryption_in_transit_enabled = optional(bool)
          launch_mode                         = optional(string)
          metadata                            = optional(map(string))
          preferred_maintenance_action        = optional(string)
          shape                               = optional(string)
          agent_config = optional(list(object({
            are_all_plugins_disabled = optional(bool)
            is_management_disabled   = optional(bool)
            is_monitoring_disabled   = optional(bool)
            plugins_config = optional(list(object({
              desired_state = string
              name          = string
            })))
          })))
          availability_config = optional(list(object({
            is_live_migration_preferred = optional(bool)
            recovery_action             = optional(string)
          })))
          create_vnic_details = optional(list(object({
            assign_ipv6ip             = optional(bool)
            assign_private_dns_record = optional(bool)
            assign_public_ip          = optional(string)
            defined_tags              = optional(map(string))
            display_name              = optional(string)
            freeform_tags             = optional(map(string))
            hostname_label            = optional(string)
            nsg_ids                   = optional(list(string))
            private_ip                = optional(string)
            skip_source_dest_check    = optional(bool)
            subnet_id                 = optional(any)
            vlan_id                   = optional(any)
          })))
          instance_options = optional(list(object({
            are_legacy_imds_endpoints_disabled = optional(bool)
          })))
          launch_options = optional(list(object({
            boot_volume_type                    = optional(string)
            firmware                            = optional(string)
            is_consistent_volume_naming_enabled = optional(bool)
            is_pv_encryption_in_transit_enabled = optional(bool)
            network_type                        = optional(string)
            remote_data_volume_type             = optional(string)
          })))
          launch_volume_attachments = optional(list(object({
            type                              = string
            device                            = optional(string)
            display_name                      = optional(string)
            encryption_in_transit_type        = optional(string)
            is_agent_auto_iscsi_login_enabled = optional(bool)
            is_read_only                      = optional(bool)
            is_shareable                      = optional(bool)
            use_chap                          = optional(bool)
            volume_id                         = optional(string)
            launch_create_volume_details = optional(list(object({
              size_in_gbs          = optional(string)
              volume_creation_type = optional(string)
              compartment_id       = optional(any)
              display_name         = optional(string)
              kms_key_id           = optional(any)
              vpus_per_gb          = optional(string)
            })))
          })))
          platform_config = optional(list(object({
            type                                           = string
            are_virtual_instructions_enabled               = optional(bool)
            config_map                                     = optional(map(string))
            is_access_control_service_enabled              = optional(bool)
            is_input_output_memory_management_unit_enabled = optional(bool)
            is_measured_boot_enabled                       = optional(bool)
            is_memory_encryption_enabled                   = optional(bool)
            is_secure_boot_enabled                         = optional(bool)
            is_symmetric_multi_threading_enabled           = optional(bool)
            is_trusted_platform_module_enabled             = optional(bool)
            numa_nodes_per_socket                          = optional(string)
            percentage_of_cores_enabled                    = optional(number)
          })))
          preemptible_instance_config = optional(list(object({
            preemption_action = list(object({
              type                 = string
              preserve_boot_volume = optional(bool)
            }))
          })))
          shape_config = optional(list(object({
            baseline_ocpu_utilization = optional(string)
            memory_in_gbs             = optional(number)
            nvmes                     = optional(number)
            ocpus                     = optional(number)
            vcpus                     = optional(number)
          })))
          source_details = optional(list(object({
            source_type                     = string
            source_type                     = optional(string)
            source_id                       = optional(string)
            boot_volume_size_in_gbs         = optional(string)
            boot_volume_vpus_per_gb         = optional(string)
            kms_key_id                      = optional(string)
            is_preserve_boot_volume_enabled = optional(bool)
            instance_source_image_filter_details = optional(list(object({
              compartment_id           = any
              defined_tags_filter      = optional(map(string))
              operating_system         = optional(string)
              operating_system_version = optional(string)
            })))
          })))
        })))
        secondary_vnics = optional(list(object({
          create_vnic_details = optional(list(object({
            assign_ipv6ip             = optional(bool)
            assign_private_dns_record = optional(bool)
            assign_public_ip          = optional(bool)
            defined_tags              = optional(map(string))
            display_name              = optional(string)
            freeform_tags             = optional(map(string))
            hostname_label            = optional(string)
            nsg_ids                   = optional(list(string))
            private_ip                = optional(string)
            skip_source_dest_check    = optional(bool)
            subnet_id                 = optional(string)
            ipv6address_ipv6subnet_cidr_pair_details = optional(list(object({
              ipv6subnet_cidr = optional(string)
              ipv6address     = optional(string)
            })))
          })))
        })))
      })))
      secondary_vnics = optional(list(object({
        assign_ipv6ip             = optional(bool)
        assign_private_dns_record = optional(bool)
        assign_public_ip          = optional(bool)
        defined_tags              = optional(map(string))
        display_name              = optional(string)
        freeform_tags             = optional(map(string))
        hostname_label            = optional(string)
        nsg_ids                   = optional(list(string))
        private_ip                = optional(string)
        skip_source_dest_check    = optional(bool)
        subnet_id                 = optional(string)
        ipv6address_ipv6subnet_cidr_pair_details = optional(list(object({
          ipv6subnet_cidr = optional(string)
          ipv6address     = optional(string)
        })))
      })))
    })))
  }))
}

variable "instance_pool" {
  type = list(object({
    id                              = number
    compartment_id                  = any
    instance_configuration_id       = any
    size                            = number
    defined_tags                    = optional(map(string))
    display_name                    = optional(string)
    freeform_tags                   = optional(map(string))
    instance_display_name_formatter = optional(string)
    instance_hostname_formatter     = optional(string)
    state                           = optional(string)
    load_balancer = optional(list(object({
      backend_set_name = any
      load_balancer_id = any
      port             = number
      vnic_selection   = string
    })))
    placement_configuration = list(object({
      availability_domaine = string
      fault_domains        = optional(list(string))
      primary_subnet_id    = optional(any)
      primary_vnic_subnets = optional(list(object({
        subnet_id        = any
        is_assign_ipv6ip = optional(bool)
        ipv6address_ipv6subnet_cidr_pair_details = optional(list(object({
          ipv6subnet_cidr = optional(string)
        })))
      })))
      secondary_vnic_subnets = optional(list(object({
        subnet_id    = any
        display_name = optional(string)
        ipv6address_ipv6subnet_cidr_pair_details = optional(list(object({
          ipv6subnet_cidr = optional(string)
        })))
      })))
    }))
  }))
  default = []
}

variable "instance_pool_instance" {
  type = list(object({
    id               = number
    instance_id      = any
    instance_pool_id = any
  }))
  default = []
}

variable "internet_gateway" {
  type = list(object({
    id             = number
    compartment_id = any
    vcn_id         = any
    defined_tags   = optional(map(string))
    display_name   = optional(string)
    enabled        = optional(bool)
    freeform_tags  = optional(map(string))
    route_table_id = optional(any)
  }))
  default = []
}

variable "ipsec" {
  type = list(object({
    id                        = number
    compartment_id            = any
    cpe_id                    = any
    drg_id                    = any
    static_routes             = list(string)
    cpe_local_identifier      = optional(string)
    cpe_local_identifier_type = optional(string)
    defined_tags              = optional(map(string))
    display_name              = optional(string)
    freeform_tags             = optional(map(string))
  }))
  default = []
}

variable "ipsec_connection_tunnels" {
  type = list(object({
    id                      = number
    ipsec_id                = any
    tunnel_id               = any
    display_name            = optional(string)
    shared_secret           = optional(string)
    ike_version             = optional(string)
    routing                 = optional(string)
    nat_translation_enabled = optional(string)
    oracle_can_initiate     = optional(string)
    bgp_session_info = optional(list(object({
      customer_bgp_asn        = optional(string)
      customer_interface_ip   = optional(string)
      customer_interface_ipv6 = optional(string)
      oracle_interface_ip     = optional(string)
      oracle_interface_ipv6   = optional(string)
    })))
    dpd_config = optional(list(object({
      dpd_mode           = optional(string)
      dpd_timeout_in_sec = optional(number)
    })))
    encryption_domain_config = optional(list(object({
      cpe_traffic_selector    = optional(list(string))
      oracle_traffic_selector = optional(list(string))
    })))
    phase_one_details = optional(list(object({
      custom_authentication_algorithm = optional(string)
      custom_dh_group                 = optional(string)
      custom_encryption_algorithm     = optional(string)
      is_custom_phase_one_config      = optional(bool)
      lifetime                        = optional(number)
    })))
    phase_two_details = optional(list(object({
      custom_authentication_algorithm = optional(string)
      custom_encryption_algorithm     = optional(string)
      dh_group                        = optional(string)
      is_custom_phase_two_config      = optional(bool)
      is_pfs_enabled                  = optional(bool)
      lifetime                        = optional(number)
    })))
  }))
  default = []
}

variable "ipsec_connection_tunnel" {
  type = list(object({
    id        = number
    ipsec_id  = any
    tunnel_id = any
  }))
  default = []
}

variable "ipsec_connection_tunnel_management" {
  type = list(object({
    id        = number
    ipsec_id  = any
    tunnel_id = any
  }))
  default = []
}

variable "ipv6" {
  type = list(object({
    id              = number
    vnic_id         = any
    defined_tags    = optional(map(string))
    display_name    = optional(string)
    freeform_tags   = optional(map(string))
    ip_address      = optional(string)
    ipv6subnet_cidr = optional(string)
  }))
  default = []
}

variable "local_peering_gateway" {
  type = list(object({
    id             = number
    compartment_id = any
    vcn_id         = any
    defined_tags   = optional(map(string))
    display_name   = optional(string)
    freeform_tags  = optional(map(string))
    peer_id        = optional(any)
    route_table_id = optional(any)
  }))
  default = []
}

variable "nat_gateway" {
  type = list(object({
    id             = number
    compartment_id = any
    vcn_id         = any
    block_traffic  = optional(bool)
    defined_tags   = optional(map(string))
    display_name   = optional(string)
    freeform_tags  = optional(map(string))
    public_ip_id   = optional(any)
    route_table_id = optional(any)
  }))
  default = []
}

variable "network_security_group" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "network_security_group_security_rule" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "private_ip" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "public_ip" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "public_ip_pool" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "public_ip_pool_capacity" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "remote_peering_connection" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "route_table" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "route_table_attachment" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "security_list" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "service_gateway" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "shape_management" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "subnet" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "vcn" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "virtual_circuit" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "vlan" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "vnic_attachment" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "volume" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "volume_attachment" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "volume_backup" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "volume_backup_policy" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "volume_backup_policy_assignment" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "volume_group" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "volume_group_backup" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "vtap" {
  type = list(object({
    id = number
  }))
  default = []
}
