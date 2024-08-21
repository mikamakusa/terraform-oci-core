## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | >= 6.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | >= 6.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_identity"></a> [identity](#module\_identity) | modules/terraform-oci-identity | n/a |
| <a name="module_kms"></a> [kms](#module\_kms) | modules/terraform-oci-kms | n/a |

## Resources Graphe

```mermaid
flowchart LR
module.identity ---> oci_core_app_catalog_listing_resource_version_agreement
oci_core_app_catalog_listing_resource_version_agreement ---> oci_core_app_catalog_subscription
module.identity ---> oci_core_boot_volume ---> module.kms
oci_core_app_catalog_listing_resource_version_agreement ---> oci_core_boot_volume
oci_core_boot_volume ---> oci_core_boot_volume_backup ---> module.kms
module.identity ---> oci_core_boot_volume_backup
module.identity ---> oci_core_capture_filter
module.identity ---> oci_core_cluster_network
module.identity ---> oci_core_compute_capacity_report
module.identity ---> oci_core_compute_capacity_reservation
module.identity ---> oci_core_compute_capacity_topology
module.identity ---> oci_core_compute_cluster
module.identity ---> oci_core_compute_image_capability_schema
module.identity ---> oci_core_cpe
module.identity ---> oci_core_cross_connect
module.identity ---> oci_core_cross_connect_group
module.identity ---> oci_core_dedicated_vm_host
module.identity ---> oci_core_dhcp_options ---> oci_core_vcn
module.identity ---> oci_core_drg ---> oci_core_drg_attachment ---> oci_core_drg_attachment_management
oci_core_drg ---> oci_core_drg_attachments_list
oci_core_drg ---> oci_core_drg_route_distribution ---> oci_core_drg_route_distribution_statement
oci_core_drg ---> oci_core_drg_route_table
oci_core_drg ---> oci_core_drg_route_table_route_rule
oci_core_drg_attachment ---> oci_core_drg_route_table_route_rule
module.identity ---> oci_core_image
oci_core_instance ---> oci_core_console_history
module.identity ---> oci_core_instance
oci_core_instance ---> oci_core_instance_console_connection
oci_core_instance ---> oci_core_compute_capacity_reservation
oci_core_instance ---> oci_core_compute_cluster
oci_core_instance ---> oci_core_dedicated_vm_host
oci_core_instance ---> oci_core_subnet
oci_core_instance ---> oci_core_vlan
oci_core_instance ---> oci_core_boot_volume
oci_core_instance ---> oci_core_image
oci_core_instance ---> module.kms
oci_core_instance_console_connection ---> oci_core_instance
```

## Resources

| Name | Type |
|------|------|
| [oci_core_app_catalog_listing_resource_version_agreement.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_app_catalog_listing_resource_version_agreement) | resource |
| [oci_core_app_catalog_subscription.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_app_catalog_subscription) | resource |
| [oci_core_boot_volume.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_boot_volume) | resource |
| [oci_core_boot_volume_backup.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_boot_volume_backup) | resource |
| [oci_core_capture_filter.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_capture_filter) | resource |
| [oci_core_cluster_network.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_cluster_network) | resource |
| [oci_core_compute_capacity_report.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_compute_capacity_report) | resource |
| [oci_core_compute_capacity_reservation.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_compute_capacity_reservation) | resource |
| [oci_core_compute_capacity_topology.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_compute_capacity_topology) | resource |
| [oci_core_compute_cluster.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_compute_cluster) | resource |
| [oci_core_compute_image_capability_schema.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_compute_image_capability_schema) | resource |
| [oci_core_console_history.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_console_history) | resource |
| [oci_core_cpe.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_cpe) | resource |
| [oci_core_cross_connect.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_cross_connect) | resource |
| [oci_core_cross_connect_group.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_cross_connect_group) | resource |
| [oci_core_dedicated_vm_host.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_dedicated_vm_host) | resource |
| [oci_core_dhcp_options.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_dhcp_options) | resource |
| [oci_core_drg.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg) | resource |
| [oci_core_drg_attachment.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_attachment) | resource |
| [oci_core_drg_attachment_management.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_attachment_management) | resource |
| [oci_core_drg_attachments_list.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_attachments_list) | resource |
| [oci_core_drg_route_distribution.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_route_distribution) | resource |
| [oci_core_drg_route_distribution_statement.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_route_distribution_statement) | resource |
| [oci_core_drg_route_table.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_route_table) | resource |
| [oci_core_drg_route_table_route_rule.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_route_table_route_rule) | resource |
| [oci_core_image.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_image) | resource |
| [oci_core_instance.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance) | resource |
| [oci_core_instance_console_connection.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance_console_connection) | resource |
| [oci_core_instance_pool.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance_pool) | resource |
| [oci_core_instance_pool_instance.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance_pool_instance) | resource |
| [oci_core_internet_gateway.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_internet_gateway) | resource |
| [oci_core_ipsec.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_ipsec) | resource |
| [oci_core_ipsec_connection_tunnel_management.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_ipsec_connection_tunnel_management) | resource |
| [oci_core_ipv6.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_ipv6) | resource |
| [oci_core_local_peering_gateway.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_local_peering_gateway) | resource |
| [oci_core_nat_gateway.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_nat_gateway) | resource |
| [oci_core_network_security_group.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_network_security_group) | resource |
| [oci_core_network_security_group_security_rule.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_network_security_group_security_rule) | resource |
| [oci_core_private_ip.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_private_ip) | resource |
| [oci_core_public_ip.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_public_ip) | resource |
| [oci_core_public_ip_pool.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_public_ip_pool) | resource |
| [oci_core_public_ip_pool_capacity.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_public_ip_pool_capacity) | resource |
| [oci_core_remote_peering_connection.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_remote_peering_connection) | resource |
| [oci_core_route_table.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_route_table) | resource |
| [oci_core_route_table_attachment.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_route_table_attachment) | resource |
| [oci_core_security_list.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list) | resource |
| [oci_core_service_gateway.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_service_gateway) | resource |
| [oci_core_shape_management.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_shape_management) | resource |
| [oci_core_subnet.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet) | resource |
| [oci_core_vcn.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn) | resource |
| [oci_core_virtual_circuit.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_virtual_circuit) | resource |
| [oci_core_virtual_network.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_virtual_network) | resource |
| [oci_core_vlan.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vlan) | resource |
| [oci_core_vnic_attachment.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vnic_attachment) | resource |
| [oci_core_volume.his](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume) | resource |
| [oci_core_volume_attachment.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_attachment) | resource |
| [oci_core_volume_backup.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_backup) | resource |
| [oci_core_volume_backup_policy.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_backup_policy) | resource |
| [oci_core_volume_backup_policy_assignment.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_backup_policy_assignment) | resource |
| [oci_core_volume_group.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_group) | resource |
| [oci_core_volume_group_backup.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_group_backup) | resource |
| [oci_core_vtap.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vtap) | resource |
| [oci_core_cpe_device_shapes.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_cpe_device_shapes) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_catalog_listing_resource_version_agreement"></a> [app\_catalog\_listing\_resource\_version\_agreement](#input\_app\_catalog\_listing\_resource\_version\_agreement) | n/a | <pre>list(object({<br>    id                       = number<br>    listing_id               = any<br>    listing_resource_version = string<br>  }))</pre> | `[]` | no |
| <a name="input_app_catalog_subscription"></a> [app\_catalog\_subscription](#input\_app\_catalog\_subscription) | n/a | <pre>list(object({<br>    id                       = number<br>    compartment_id           = any<br>    listing_id               = any<br>    listing_resource_version = string<br>    oracle_terms_of_use_link = string<br>    signature                = string<br>    time_retrieved           = string<br>    eula_link                = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_boot_volume"></a> [boot\_volume](#input\_boot\_volume) | n/a | <pre>list(object({<br>    id                            = number<br>    availability_domain           = string<br>    compartment_id                = any<br>    cluster_placement_group_id    = optional(any)<br>    defined_tags                  = optional(map(string))<br>    display_name                  = optional(string)<br>    freeform_tags                 = optional(map(string))<br>    is_auto_tune_enabled          = optional(bool)<br>    kms_key_id                    = optional(any)<br>    size_in_gbs                   = optional(string)<br>    vpus_per_gb                   = optional(string)<br>    boot_volume_replicas_deletion = optional(bool)<br>    source_details = list(object({<br>      id   = string<br>      type = string<br>    }))<br>    autotune_policies = optional(list(object({<br>      autotune_type   = string<br>      max_vpus_per_gb = optional(string)<br>    })))<br>    boot_volume_replicas = optional(list(object({<br>      availability_domain = string<br>      display_name        = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_boot_volume_backup"></a> [boot\_volume\_backup](#input\_boot\_volume\_backup) | n/a | <pre>list(object({<br>    id             = number<br>    boot_volume_id = any<br>    defined_tags   = optional(map(string))<br>    display_name   = optional(string)<br>    freeform_tags  = optional(map(string))<br>    kms_key_id     = optional(any)<br>    type           = optional(string)<br>    source_details = optional(list(object({<br>      boot_volume_backup_id = any<br>      region                = string<br>      kms_key_id            = optional(any)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_capture_filter"></a> [capture\_filter](#input\_capture\_filter) | n/a | <pre>list(object({<br>    id             = number<br>    compartment_id = any<br>    filter_type    = string<br>    defined_tags   = optional(map(string))<br>    display_name   = optional(string)<br>    freeform_tags  = optional(map(string))<br>    flow_log_capture_filter_rules = optional(list(object({<br>      destination_cidr = optional(string)<br>      flow_log_type    = optional(string)<br>      is_enabled       = optional(bool)<br>      priority         = optional(number)<br>      protocol         = optional(string)<br>      rule_action      = optional(string)<br>      sampling_rate    = optional(number)<br>      source_cidr      = optional(string)<br>      icmp_options = optional(list(object({<br>        type = number<br>        code = optional(number)<br>      })))<br>      tcp_options = optional(list(object({<br>        destination_port_range = optional(list(object({<br>          max = number<br>          min = number<br>        })))<br>        source_port_range = optional(list(object({<br>          max = number<br>          min = number<br>        })))<br>      })))<br>      udp_options = optional(list(object({<br>        destination_port_range = optional(list(object({<br>          max = number<br>          min = number<br>        })))<br>        source_port_range = optional(list(object({<br>          max = number<br>          min = number<br>        })))<br>      })))<br>    })))<br>    vtap_capture_filter_rules = optional(list(object({<br>      traffic_direction = string<br>      destination_cidr  = optional(string)<br>      protocol          = optional(string)<br>      rule_action       = optional(string)<br>      source_cidr       = optional(string)<br>      icmp_options = optional(list(object({<br>        type = number<br>        code = optional(number)<br>      })))<br>      tcp_options = optional(list(object({<br>        destination_port_range = optional(list(object({<br>          max = number<br>          min = number<br>        })))<br>        source_port_range = optional(list(object({<br>          max = number<br>          min = number<br>        })))<br>      })))<br>      udp_options = optional(list(object({<br>        destination_port_range = optional(list(object({<br>          max = number<br>          min = number<br>        })))<br>        source_port_range = optional(list(object({<br>          max = number<br>          min = number<br>        })))<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_network"></a> [cluster\_network](#input\_cluster\_network) | n/a | <pre>list(object({<br>    id             = number<br>    compartment_id = any<br>    defined_tags   = optional(map(string))<br>    display_name   = optional(string)<br>    freeform_tags  = optional(map(string))<br>    instance_pools = list(object({<br>      instance_configuration_id = any<br>      size                      = number<br>      defined_tags              = optional(map(string))<br>      freeform_tags             = optional(map(string))<br>      display_name              = optional(string)<br>    }))<br>    placement_configuration = list(object({<br>      availability_domain = string<br>      primary_subnet_id   = optional(any)<br>      primary_vnic_subnets = optional(list(object({<br>        subnet_id        = any<br>        is_assign_ipv6ip = optional(bool)<br>        ipv6address_ipv6subnet_cidr_pair_details = optional(list(object({<br>          ipv6subnet_cidr = optional(string)<br>        })))<br>      })))<br>      secondary_vnic_subnets = optional(list(object({<br>        subnet_id        = any<br>        is_assign_ipv6ip = optional(bool)<br>        ipv6address_ipv6subnet_cidr_pair_details = optional(list(object({<br>          ipv6subnet_cidr = optional(string)<br>        })))<br>      })))<br>    }))<br>    cluster_configuration = optional(list(object({<br>      hpc_island_id     = any<br>      network_block_ids = optional(list(string))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_compartment"></a> [compartment](#input\_compartment) | n/a | `any` | n/a | yes |
| <a name="input_compute_capacity_report"></a> [compute\_capacity\_report](#input\_compute\_capacity\_report) | n/a | <pre>list(object({<br>    id                  = number<br>    availability_domain = string<br>    compartment_id      = any<br>    shape_availabilities = list(object({<br>      instance_shape = string<br>      fault_domain   = optional(string)<br>      instance_shape_config = optional(list(object({<br>        memory_in_gbs = optional(number)<br>        nvmes         = optional(number)<br>        ocpus         = optional(number)<br>      })))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_compute_capacity_reservation"></a> [compute\_capacity\_reservation](#input\_compute\_capacity\_reservation) | n/a | <pre>list(object({<br>    id                     = number<br>    availability_domain    = string<br>    compartment_id         = any<br>    defined_tags           = optional(map(string))<br>    display_name           = optional(string)<br>    freeform_tags          = optional(map(string))<br>    is_default_reservation = optional(bool)<br>    instance_reservation_configs = list(object({<br>      reserved_count             = string<br>      instance_shape             = string<br>      cluster_placement_group_id = optional(any)<br>      fault_domain               = optional(string)<br>      cluster_config = optional(list(object({<br>        hpc_island_id     = any<br>        network_block_ids = optional(list(string))<br>      })))<br>      instance_shape_config = optional(list(object({<br>        memory_in_gbs = optional(number)<br>        ocpus         = optional(number)<br>      })))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_compute_capacity_topology"></a> [compute\_capacity\_topology](#input\_compute\_capacity\_topology) | n/a | <pre>list(object({<br>    id                  = number<br>    availability_domain = string<br>    compartment_id      = any<br>    display_name        = optional(string)<br>    defined_tags        = optional(map(string))<br>    freeform_tags       = optional(map(string))<br>    capacity_source = list(object({<br>      capacity_type  = string<br>      compartment_id = optional(any)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_compute_cluster"></a> [compute\_cluster](#input\_compute\_cluster) | n/a | <pre>list(object({<br>    id                  = number<br>    availability_domain = string<br>    compartment_id      = any<br>    display_name        = optional(string)<br>    defined_tags        = optional(map(string))<br>    freeform_tags       = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_compute_image_capability_schema"></a> [compute\_image\_capability\_schema](#input\_compute\_image\_capability\_schema) | n/a | <pre>list(object({<br>    id                                                  = number<br>    compartment_id                                      = any<br>    compute_global_image_capability_schema_version_name = string<br>    image_id                                            = any<br>    schema_data                                         = map(any)<br>    display_name                                        = optional(string)<br>    defined_tags                                        = optional(map(string))<br>    freeform_tags                                       = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_console_history"></a> [console\_history](#input\_console\_history) | n/a | <pre>list(object({<br>    id            = number<br>    instance_id   = any<br>    display_name  = optional(string)<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_cpe"></a> [cpe](#input\_cpe) | n/a | <pre>list(object({<br>    id                  = number<br>    compartment_id      = any<br>    ip_address          = string<br>    cpe_device_shape_id = optional(any)<br>    defined_tags        = optional(map(string))<br>    display_name        = optional(string)<br>    freeform_tags       = optional(map(string))<br>    is_private          = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_cross_connect"></a> [cross\_connect](#input\_cross\_connect) | n/a | <pre>list(object({<br>    id                                           = number<br>    compartment_id                               = any<br>    location_name                                = string<br>    port_speed_shape_name                        = string<br>    cross_connect_group_id                       = optional(any)<br>    customer_reference_name                      = optional(string)<br>    defined_tags                                 = optional(map(string))<br>    display_name                                 = optional(string)<br>    far_cross_connect_or_cross_connect_group_id  = optional(any)<br>    freeform_tags                                = optional(map(string))<br>    near_cross_connect_or_cross_connect_group_id = optional(any)<br>    macsec_properties = optional(list(object({<br>      state                          = string<br>      encryption_cipher              = optional(string)<br>      is_unprotected_traffic_allowed = optional(bool)<br>      primary_key = optional(list(object({<br>        connectivity_association_key_secret_id  = optional(any)<br>        connectivity_association_name_secret_id = optional(any)<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_cross_connect_group"></a> [cross\_connect\_group](#input\_cross\_connect\_group) | n/a | <pre>list(object({<br>    id                      = number<br>    compartment_id          = any<br>    customer_reference_name = optional(string)<br>    defined_tags            = optional(map(string))<br>    display_name            = optional(string)<br>    freeform_tags           = optional(map(string))<br>    macsec_properties = optional(list(object({<br>      state                          = string<br>      encryption_cipher              = optional(string)<br>      is_unprotected_traffic_allowed = optional(bool)<br>      primary_key = optional(list(object({<br>        connectivity_association_key_secret_id  = optional(any)<br>        connectivity_association_name_secret_id = optional(any)<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_dedicated_vm_host"></a> [dedicated\_vm\_host](#input\_dedicated\_vm\_host) | n/a | <pre>list(object({<br>    id                      = number<br>    availability_domain     = string<br>    compartment_id          = any<br>    dedicated_vm_host_shape = string<br>    defined_tags            = optional(map(string))<br>    display_name            = optional(string)<br>    fault_domain            = optional(string)<br>    freeform_tags           = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_dhcp_options"></a> [dhcp\_options](#input\_dhcp\_options) | n/a | <pre>list(object({<br>    id               = number<br>    compartment_id   = any<br>    vcn_id           = any<br>    defined_tags     = optional(map(string))<br>    display_name     = optional(string)<br>    domain_name_type = optional(string)<br>    freeform_tags    = optional(map(string))<br>    options = list(object({<br>      type                = string<br>      custom_dns_servers  = optional(list(string))<br>      search_domain_names = optional(list(string))<br>      server_type         = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_drg"></a> [drg](#input\_drg) | n/a | <pre>list(object({<br>    id             = number<br>    compartment_id = any<br>    defined_tags   = optional(map(string))<br>    display_name   = optional(string)<br>    freeform_tags  = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_drg_attachment"></a> [drg\_attachment](#input\_drg\_attachment) | n/a | <pre>list(object({<br>    id                 = number<br>    drg_id             = any<br>    defined_tags       = optional(map(string))<br>    display_name       = optional(string)<br>    drg_route_table_id = optional(any)<br>    freeform_tags      = optional(map(string))<br>    network_details = optional(list(object({<br>      type           = string<br>      id             = optional(any)<br>      route_table_id = optional(any)<br>      vcn_route_type = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_drg_attachment_management"></a> [drg\_attachment\_management](#input\_drg\_attachment\_management) | n/a | <pre>list(object({<br>    id                                           = number<br>    attachment_type                              = string<br>    compartment_id                               = any<br>    drg_id                                       = any<br>    defined_tags                                 = optional(map(string))<br>    display_name                                 = optional(string)<br>    drg_route_table_id                           = optional(any)<br>    export_drg_route_distribution_id             = optional(any)<br>    freeform_tags                                = optional(map(string))<br>    network_id                                   = optional(any)<br>    remove_export_drg_route_distribution_trigger = optional(bool)<br>    route_table_id                               = optional(any)<br>    vcn_id                                       = optional(any)<br>    network_details = optional(list(object({<br>      type                = string<br>      id                  = any<br>      route_table_id      = optional(any)<br>      ipsec_connection_id = optional(any)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_drg_attachments_list"></a> [drg\_attachments\_list](#input\_drg\_attachments\_list) | n/a | <pre>list(object({<br>    id               = number<br>    drg_id           = any<br>    attachment_type  = optional(string)<br>    is_cross_tenancy = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_drg_route_distribution"></a> [drg\_route\_distribution](#input\_drg\_route\_distribution) | n/a | <pre>list(object({<br>    id                = number<br>    distribution_type = string<br>    drg_id            = any<br>    defined_tags      = optional(map(string))<br>    display_name      = optional(string)<br>    freeform_tags     = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_drg_route_distribution_statement"></a> [drg\_route\_distribution\_statement](#input\_drg\_route\_distribution\_statement) | n/a | <pre>list(object({<br>    id                        = number<br>    action                    = string<br>    drg_route_distribution_id = any<br>    priority                  = number<br>    match_criteria = list(object({<br>      match_type        = string<br>      attachment_type   = optional(string)<br>      drg_attachment_id = optional(any)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_drg_route_table"></a> [drg\_route\_table](#input\_drg\_route\_table) | n/a | <pre>list(object({<br>    id                               = number<br>    drg_id                           = any<br>    defined_tags                     = optional(map(string))<br>    display_name                     = optional(string)<br>    freeform_tags                    = optional(map(string))<br>    import_drg_route_distribution_id = optional(any)<br>    is_ecmp_enabled                  = optional(bool)<br>    remove_import_trigger            = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_drg_route_table_route_rule"></a> [drg\_route\_table\_route\_rule](#input\_drg\_route\_table\_route\_rule) | n/a | <pre>list(object({<br>    id                         = number<br>    destination                = string<br>    destination_type           = string<br>    drg_route_table_id         = any<br>    next_hop_drg_attachment_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_image"></a> [image](#input\_image) | n/a | <pre>list(object({<br>    id            = number<br>    defined_tags  = optional(map(string))<br>    display_name  = optional(string)<br>    freeform_tags = optional(map(string))<br>    instance_id   = optional(any)<br>    launch_mode   = optional(string)<br>    image_source_details = optional(list(object({<br>      source_type              = string<br>      namespace_name           = optional(string)<br>      object_name              = optional(string)<br>      operating_system         = optional(string)<br>      operating_system_version = optional(string)<br>      source_image_type        = optional(string)<br>      source_uri               = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | n/a | <pre>list(object({<br>    id                                      = number<br>    availability_domain                     = string<br>    compartment_id                          = any<br>    shape                                   = string<br>    async                                   = optional(bool)<br>    capacity_reservation_id                 = optional(any)<br>    cluster_placement_group_id              = optional(any)<br>    compute_cluster_id                      = optional(any)<br>    dedicated_vm_host_id                    = optional(any)<br>    defined_tags                            = optional(map(string))<br>    display_name                            = optional(string)<br>    extended_metadata                       = optional(map(string))<br>    fault_domain                            = optional(string)<br>    freeform_tags                           = optional(map(string))<br>    instance_configuration_id               = optional(any)<br>    ipxe_script                             = optional(string)<br>    is_pv_encryption_in_transit_enabled     = optional(bool)<br>    metadata                                = optional(map(string))<br>    preserve_boot_volume                    = optional(bool)<br>    preserve_data_volumes_created_at_launch = optional(bool)<br>    state                                   = optional(string)<br>    update_operation_constraint             = optional(string)<br>    agent_config = optional(list(object({<br>      are_all_plugins_disabled = optional(bool)<br>      is_management_disabled   = optional(bool)<br>      is_monitoring_disabled   = optional(bool)<br>      plugins_config = optional(list(object({<br>        desired_state = string<br>        name          = string<br>      })))<br>    })))<br>    availability_config = optional(list(object({<br>      is_live_migration_preferred = optional(bool)<br>      recovery_action             = optional(string)<br>    })))<br>    create_vnic_details = optional(list(object({<br>      assign_ipv6ip             = optional(bool)<br>      assign_private_dns_record = optional(bool)<br>      assign_public_ip          = optional(string)<br>      defined_tags              = optional(map(string))<br>      display_name              = optional(string)<br>      freeform_tags             = optional(map(string))<br>      hostname_label            = optional(string)<br>      nsg_ids                   = optional(list(string))<br>      private_ip                = optional(string)<br>      skip_source_dest_check    = optional(bool)<br>      subnet_id                 = optional(any)<br>      vlan_id                   = optional(any)<br>    })))<br>    instance_options = optional(list(object({<br>      are_legacy_imds_endpoints_disabled = optional(bool)<br>    })))<br>    launch_options = optional(list(object({<br>      boot_volume_type                    = optional(string)<br>      firmware                            = optional(string)<br>      is_consistent_volume_naming_enabled = optional(bool)<br>      is_pv_encryption_in_transit_enabled = optional(bool)<br>      network_type                        = optional(string)<br>      remote_data_volume_type             = optional(string)<br>    })))<br>    launch_volume_attachments = optional(list(object({<br>      type                              = string<br>      device                            = optional(string)<br>      display_name                      = optional(string)<br>      encryption_in_transit_type        = optional(string)<br>      is_agent_auto_iscsi_login_enabled = optional(bool)<br>      is_read_only                      = optional(bool)<br>      is_shareable                      = optional(bool)<br>      use_chap                          = optional(bool)<br>      volume_id                         = optional(string)<br>      launch_create_volume_details = optional(list(object({<br>        size_in_gbs          = optional(string)<br>        volume_creation_type = optional(string)<br>        compartment_id       = optional(any)<br>        display_name         = optional(string)<br>        kms_key_id           = optional(any)<br>        vpus_per_gb          = optional(string)<br>      })))<br>    })))<br>    platform_config = optional(list(object({<br>      type                                           = string<br>      are_virtual_instructions_enabled               = optional(bool)<br>      config_map                                     = optional(map(string))<br>      is_access_control_service_enabled              = optional(bool)<br>      is_input_output_memory_management_unit_enabled = optional(bool)<br>      is_measured_boot_enabled                       = optional(bool)<br>      is_memory_encryption_enabled                   = optional(bool)<br>      is_secure_boot_enabled                         = optional(bool)<br>      is_symmetric_multi_threading_enabled           = optional(bool)<br>      is_trusted_platform_module_enabled             = optional(bool)<br>      numa_nodes_per_socket                          = optional(string)<br>      percentage_of_cores_enabled                    = optional(number)<br>    })))<br>    preemptible_instance_config = optional(list(object({<br>      preemption_action = list(object({<br>        type                 = string<br>        preserve_boot_volume = optional(bool)<br>      }))<br>    })))<br>    shape_config = optional(list(object({<br>      baseline_ocpu_utilization = optional(string)<br>      memory_in_gbs             = optional(number)<br>      nvmes                     = optional(number)<br>      ocpus                     = optional(number)<br>      vcpus                     = optional(number)<br>    })))<br>    source_details = optional(list(object({<br>      source_type                     = string<br>      source_type                     = optional(string)<br>      source_id                       = optional(string)<br>      boot_volume_size_in_gbs         = optional(string)<br>      boot_volume_vpus_per_gb         = optional(string)<br>      kms_key_id                      = optional(string)<br>      is_preserve_boot_volume_enabled = optional(bool)<br>      instance_source_image_filter_details = optional(list(object({<br>        compartment_id           = any<br>        defined_tags_filter      = optional(map(string))<br>        operating_system         = optional(string)<br>        operating_system_version = optional(string)<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_instance_console_connection"></a> [instance\_console\_connection](#input\_instance\_console\_connection) | n/a | <pre>list(object({<br>    id            = number<br>    instance_id   = any<br>    public_key    = string<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_instance_pool"></a> [instance\_pool](#input\_instance\_pool) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_instance_pool_instance"></a> [instance\_pool\_instance](#input\_instance\_pool\_instance) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_internet_gateway"></a> [internet\_gateway](#input\_internet\_gateway) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_ipsec"></a> [ipsec](#input\_ipsec) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_ipsec_connection_tunnel_management"></a> [ipsec\_connection\_tunnel\_management](#input\_ipsec\_connection\_tunnel\_management) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_ipv6"></a> [ipv6](#input\_ipv6) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_local_peering_gateway"></a> [local\_peering\_gateway](#input\_local\_peering\_gateway) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_nat_gateway"></a> [nat\_gateway](#input\_nat\_gateway) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_network_security_group"></a> [network\_security\_group](#input\_network\_security\_group) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_network_security_group_security_rule"></a> [network\_security\_group\_security\_rule](#input\_network\_security\_group\_security\_rule) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_public_ip_pool"></a> [public\_ip\_pool](#input\_public\_ip\_pool) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_public_ip_pool_capacity"></a> [public\_ip\_pool\_capacity](#input\_public\_ip\_pool\_capacity) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_remote_peering_connection"></a> [remote\_peering\_connection](#input\_remote\_peering\_connection) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_route_table"></a> [route\_table](#input\_route\_table) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_route_table_attachment"></a> [route\_table\_attachment](#input\_route\_table\_attachment) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_security_list"></a> [security\_list](#input\_security\_list) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_service_gateway"></a> [service\_gateway](#input\_service\_gateway) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_shape_management"></a> [shape\_management](#input\_shape\_management) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_vcn"></a> [vcn](#input\_vcn) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_virtual_circuit"></a> [virtual\_circuit](#input\_virtual\_circuit) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_vlan"></a> [vlan](#input\_vlan) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_vnic_attachment"></a> [vnic\_attachment](#input\_vnic\_attachment) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_volume"></a> [volume](#input\_volume) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_volume_attachment"></a> [volume\_attachment](#input\_volume\_attachment) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_volume_backup"></a> [volume\_backup](#input\_volume\_backup) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_volume_backup_policy"></a> [volume\_backup\_policy](#input\_volume\_backup\_policy) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_volume_backup_policy_assignment"></a> [volume\_backup\_policy\_assignment](#input\_volume\_backup\_policy\_assignment) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_volume_group"></a> [volume\_group](#input\_volume\_group) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_volume_group_backup"></a> [volume\_group\_backup](#input\_volume\_group\_backup) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |
| <a name="input_vtap"></a> [vtap](#input\_vtap) | n/a | <pre>list(object({<br>    id = number<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_catalog_listing_resource_version_agreement_id"></a> [app\_catalog\_listing\_resource\_version\_agreement\_id](#output\_app\_catalog\_listing\_resource\_version\_agreement\_id) | n/a |
| <a name="output_app_catalog_listing_resource_version_agreement_listing_id"></a> [app\_catalog\_listing\_resource\_version\_agreement\_listing\_id](#output\_app\_catalog\_listing\_resource\_version\_agreement\_listing\_id) | n/a |
| <a name="output_app_catalog_subscription_compartment_id"></a> [app\_catalog\_subscription\_compartment\_id](#output\_app\_catalog\_subscription\_compartment\_id) | n/a |
| <a name="output_app_catalog_subscription_eula_link"></a> [app\_catalog\_subscription\_eula\_link](#output\_app\_catalog\_subscription\_eula\_link) | n/a |
| <a name="output_app_catalog_subscription_id"></a> [app\_catalog\_subscription\_id](#output\_app\_catalog\_subscription\_id) | n/a |
| <a name="output_app_catalog_subscription_listing_id"></a> [app\_catalog\_subscription\_listing\_id](#output\_app\_catalog\_subscription\_listing\_id) | n/a |
| <a name="output_boot_volume_backup_id"></a> [boot\_volume\_backup\_id](#output\_boot\_volume\_backup\_id) | n/a |
| <a name="output_boot_volume_id"></a> [boot\_volume\_id](#output\_boot\_volume\_id) | n/a |
| <a name="output_boot_volume_state"></a> [boot\_volume\_state](#output\_boot\_volume\_state) | n/a |
| <a name="output_capture_filter_compartment_id"></a> [capture\_filter\_compartment\_id](#output\_capture\_filter\_compartment\_id) | n/a |
| <a name="output_capture_filter_id"></a> [capture\_filter\_id](#output\_capture\_filter\_id) | n/a |
| <a name="output_capture_filter_state"></a> [capture\_filter\_state](#output\_capture\_filter\_state) | n/a |
| <a name="output_cluster_network_id"></a> [cluster\_network\_id](#output\_cluster\_network\_id) | n/a |
| <a name="output_cluster_network_state"></a> [cluster\_network\_state](#output\_cluster\_network\_state) | n/a |
| <a name="output_compute_capacity_report_availability_domain"></a> [compute\_capacity\_report\_availability\_domain](#output\_compute\_capacity\_report\_availability\_domain) | n/a |
| <a name="output_compute_capacity_report_id"></a> [compute\_capacity\_report\_id](#output\_compute\_capacity\_report\_id) | n/a |
| <a name="output_compute_capacity_reservation_display_name"></a> [compute\_capacity\_reservation\_display\_name](#output\_compute\_capacity\_reservation\_display\_name) | n/a |
| <a name="output_compute_capacity_reservation_id"></a> [compute\_capacity\_reservation\_id](#output\_compute\_capacity\_reservation\_id) | n/a |
| <a name="output_compute_capacity_reservation_state"></a> [compute\_capacity\_reservation\_state](#output\_compute\_capacity\_reservation\_state) | n/a |
| <a name="output_compute_capacity_topology_display_name"></a> [compute\_capacity\_topology\_display\_name](#output\_compute\_capacity\_topology\_display\_name) | n/a |
| <a name="output_compute_capacity_topology_id"></a> [compute\_capacity\_topology\_id](#output\_compute\_capacity\_topology\_id) | n/a |
| <a name="output_compute_capacity_topology_state"></a> [compute\_capacity\_topology\_state](#output\_compute\_capacity\_topology\_state) | n/a |
| <a name="output_compute_cluster_id"></a> [compute\_cluster\_id](#output\_compute\_cluster\_id) | n/a |
| <a name="output_compute_cluster_state"></a> [compute\_cluster\_state](#output\_compute\_cluster\_state) | n/a |
| <a name="output_compute_image_capability_schema_display_name"></a> [compute\_image\_capability\_schema\_display\_name](#output\_compute\_image\_capability\_schema\_display\_name) | n/a |
| <a name="output_compute_image_capability_schema_id"></a> [compute\_image\_capability\_schema\_id](#output\_compute\_image\_capability\_schema\_id) | n/a |
| <a name="output_console_history_display_name"></a> [console\_history\_display\_name](#output\_console\_history\_display\_name) | n/a |
| <a name="output_console_history_id"></a> [console\_history\_id](#output\_console\_history\_id) | n/a |
| <a name="output_console_history_state"></a> [console\_history\_state](#output\_console\_history\_state) | n/a |
| <a name="output_cpe_device_shape_id"></a> [cpe\_device\_shape\_id](#output\_cpe\_device\_shape\_id) | n/a |
| <a name="output_cpe_display_name"></a> [cpe\_display\_name](#output\_cpe\_display\_name) | n/a |
| <a name="output_cpe_id"></a> [cpe\_id](#output\_cpe\_id) | n/a |
| <a name="output_cpe_is_private"></a> [cpe\_is\_private](#output\_cpe\_is\_private) | n/a |
| <a name="output_cross_connect_group_id"></a> [cross\_connect\_group\_id](#output\_cross\_connect\_group\_id) | n/a |
| <a name="output_cross_connect_id"></a> [cross\_connect\_id](#output\_cross\_connect\_id) | n/a |
| <a name="output_cross_connect_state"></a> [cross\_connect\_state](#output\_cross\_connect\_state) | n/a |
| <a name="output_dedicated_vm_host_id"></a> [dedicated\_vm\_host\_id](#output\_dedicated\_vm\_host\_id) | n/a |
| <a name="output_dedicated_vm_host_state"></a> [dedicated\_vm\_host\_state](#output\_dedicated\_vm\_host\_state) | n/a |
| <a name="output_drg_all_attachments"></a> [drg\_all\_attachments](#output\_drg\_all\_attachments) | n/a |
| <a name="output_drg_attachment_export_drg_route_distribution_id"></a> [drg\_attachment\_export\_drg\_route\_distribution\_id](#output\_drg\_attachment\_export\_drg\_route\_distribution\_id) | n/a |
| <a name="output_drg_attachment_id"></a> [drg\_attachment\_id](#output\_drg\_attachment\_id) | n/a |
| <a name="output_drg_attachment_is_cross_tenancy"></a> [drg\_attachment\_is\_cross\_tenancy](#output\_drg\_attachment\_is\_cross\_tenancy) | n/a |
| <a name="output_drg_attachment_list_id"></a> [drg\_attachment\_list\_id](#output\_drg\_attachment\_list\_id) | n/a |
| <a name="output_drg_attachment_management_export_drg_route_distribution_id"></a> [drg\_attachment\_management\_export\_drg\_route\_distribution\_id](#output\_drg\_attachment\_management\_export\_drg\_route\_distribution\_id) | n/a |
| <a name="output_drg_attachment_management_id"></a> [drg\_attachment\_management\_id](#output\_drg\_attachment\_management\_id) | n/a |
| <a name="output_drg_attachment_management_is_cross_tenancy"></a> [drg\_attachment\_management\_is\_cross\_tenancy](#output\_drg\_attachment\_management\_is\_cross\_tenancy) | n/a |
| <a name="output_drg_attachment_management_route_table_id"></a> [drg\_attachment\_management\_route\_table\_id](#output\_drg\_attachment\_management\_route\_table\_id) | n/a |
| <a name="output_drg_attachment_route_table_id"></a> [drg\_attachment\_route\_table\_id](#output\_drg\_attachment\_route\_table\_id) | n/a |
| <a name="output_drg_attachment_state"></a> [drg\_attachment\_state](#output\_drg\_attachment\_state) | n/a |
| <a name="output_drg_default_drg_route_tables"></a> [drg\_default\_drg\_route\_tables](#output\_drg\_default\_drg\_route\_tables) | n/a |
| <a name="output_drg_default_export_drg_route_distribution_id"></a> [drg\_default\_export\_drg\_route\_distribution\_id](#output\_drg\_default\_export\_drg\_route\_distribution\_id) | n/a |
| <a name="output_drg_id"></a> [drg\_id](#output\_drg\_id) | n/a |
| <a name="output_drg_redundancy_status"></a> [drg\_redundancy\_status](#output\_drg\_redundancy\_status) | n/a |
| <a name="output_drg_route_distribution_id"></a> [drg\_route\_distribution\_id](#output\_drg\_route\_distribution\_id) | n/a |
| <a name="output_drg_route_distribution_statement_id"></a> [drg\_route\_distribution\_statement\_id](#output\_drg\_route\_distribution\_statement\_id) | n/a |
| <a name="output_drg_route_distribution_statement_priority"></a> [drg\_route\_distribution\_statement\_priority](#output\_drg\_route\_distribution\_statement\_priority) | n/a |
| <a name="output_drg_route_distribution_statement_route_distribution_id"></a> [drg\_route\_distribution\_statement\_route\_distribution\_id](#output\_drg\_route\_distribution\_statement\_route\_distribution\_id) | n/a |
| <a name="output_drg_route_table_id"></a> [drg\_route\_table\_id](#output\_drg\_route\_table\_id) | n/a |
| <a name="output_drg_route_table_import_drg_route_distribution_id"></a> [drg\_route\_table\_import\_drg\_route\_distribution\_id](#output\_drg\_route\_table\_import\_drg\_route\_distribution\_id) | n/a |
| <a name="output_drg_route_table_route_rule_destination"></a> [drg\_route\_table\_route\_rule\_destination](#output\_drg\_route\_table\_route\_rule\_destination) | n/a |
| <a name="output_drg_route_table_route_rule_destination_type"></a> [drg\_route\_table\_route\_rule\_destination\_type](#output\_drg\_route\_table\_route\_rule\_destination\_type) | n/a |
| <a name="output_drg_route_table_route_rule_id"></a> [drg\_route\_table\_route\_rule\_id](#output\_drg\_route\_table\_route\_rule\_id) | n/a |
| <a name="output_drg_route_table_state"></a> [drg\_route\_table\_state](#output\_drg\_route\_table\_state) | n/a |
| <a name="output_image_id"></a> [image\_id](#output\_image\_id) | n/a |
| <a name="output_image_instance_id"></a> [image\_instance\_id](#output\_image\_instance\_id) | n/a |
| <a name="output_image_launch_mode"></a> [image\_launch\_mode](#output\_image\_launch\_mode) | n/a |
| <a name="output_instance_configuration_id"></a> [instance\_configuration\_id](#output\_instance\_configuration\_id) | n/a |
| <a name="output_instance_console_connection_id"></a> [instance\_console\_connection\_id](#output\_instance\_console\_connection\_id) | n/a |
| <a name="output_instance_console_connection_state"></a> [instance\_console\_connection\_state](#output\_instance\_console\_connection\_state) | n/a |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
