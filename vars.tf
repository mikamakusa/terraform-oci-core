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
    id = number
  }))
  default = []
}

variable "cross_connect" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "cross_connect_group" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "dedicated_vm_host" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "dhcp_options" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "drg" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "drg_attachment" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "drg_attachment_management" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "drg_attachments_list" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "drg_route_distribution" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "drg_route_distribution_statement" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "drg_route_table" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "drg_route_table_route_rule" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "image" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "instance" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "instance_console_connection" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "instance_pool" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "instance_pool_instance" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "internet_gateway" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "ipsec" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "ipsec_connection_tunnel_management" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "ipv6" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "local_peering_gateway" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "nat_gateway" {
  type = list(object({
    id = number
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
