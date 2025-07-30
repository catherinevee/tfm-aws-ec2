# EC2 Instance Configuration
variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "ec2-instance"

  validation {
    condition     = length(var.instance_name) > 0 && length(var.instance_name) <= 255
    error_message = "Instance name must be between 1 and 255 characters."
  }
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1

  validation {
    condition     = var.instance_count > 0 && var.instance_count <= 100
    error_message = "Instance count must be between 1 and 100."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = can(regex("^[a-z][0-9]+\\.[a-z0-9]+$", var.instance_type))
    error_message = "Instance type must be a valid AWS instance type."
  }
}

# AMI Configuration
variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
  default     = null
}

variable "use_latest_ami" {
  description = "Whether to use the latest Amazon Linux 2 AMI"
  type        = bool
  default     = true
}

variable "ami_type" {
  description = "Type of AMI to use (amazon_linux_2, ubuntu, custom)"
  type        = string
  default     = "amazon_linux_2"

  validation {
    condition     = contains(["amazon_linux_2", "ubuntu", "custom"], var.ami_type)
    error_message = "AMI type must be one of: amazon_linux_2, ubuntu, custom."
  }
}

variable "custom_ami_id" {
  description = "Custom AMI ID to use"
  type        = string
  default     = null
}

variable "custom_ami_owner" {
  description = "Owner of the custom AMI"
  type        = string
  default     = "self"
}

# Network Configuration
variable "vpc_id" {
  description = "VPC ID where the EC2 instance will be created"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be created"
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "Availability zone for the EC2 instance"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = false
}

variable "private_ip" {
  description = "Private IP address for the EC2 instance"
  type        = string
  default     = null
}

# Security Group Configuration
variable "create_security_group" {
  description = "Whether to create a security group for the EC2 instance"
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the EC2 instance"
  type        = list(string)
  default     = []
}

variable "security_group_name" {
  description = "Name of the security group (if not provided, will use name_prefix)"
  type        = string
  default     = null
}

variable "security_group_name_prefix" {
  description = "Name prefix for the security group"
  type        = string
  default     = null
}

variable "security_group_description" {
  description = "Description of the security group"
  type        = string
  default     = null
}

variable "security_group_ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)
    self            = bool
    ipv6_cidr_blocks = list(string)
    prefix_list_ids = list(string)
  }))
  default = [
    {
      description     = "SSH access"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      self            = false
      ipv6_cidr_blocks = []
      prefix_list_ids = []
    }
  ]
}

variable "security_group_egress_rules" {
  description = "List of egress rules for the security group"
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)
    self            = bool
    ipv6_cidr_blocks = list(string)
    prefix_list_ids = list(string)
  }))
  default = [
    {
      description     = "Allow all outbound traffic"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      self            = false
      ipv6_cidr_blocks = []
      prefix_list_ids = []
    }
  ]
}

variable "security_group_tags" {
  description = "Additional tags for the security group"
  type        = map(string)
  default     = {}
}

# Key Pair Configuration
variable "create_key_pair" {
  description = "Whether to create a key pair for SSH access"
  type        = bool
  default     = false
}

variable "key_name" {
  description = "Name of the key pair to use for SSH access"
  type        = string
  default     = null
}

variable "public_key" {
  description = "Public key for the key pair"
  type        = string
  default     = null
  sensitive   = true
}

variable "key_pair_name" {
  description = "Name of the key pair (if not provided, will use name_prefix)"
  type        = string
  default     = null
}

variable "key_pair_name_prefix" {
  description = "Name prefix for the key pair"
  type        = string
  default     = null
}

variable "key_pair_tags" {
  description = "Additional tags for the key pair"
  type        = map(string)
  default     = {}
}

# IAM Configuration
variable "create_iam_role" {
  description = "Whether to create an IAM role for the EC2 instance"
  type        = bool
  default     = false
}

variable "iam_instance_profile_name" {
  description = "Name of the IAM instance profile to use"
  type        = string
  default     = null
}

variable "iam_role_name" {
  description = "Name of the IAM role (if not provided, will use name_prefix)"
  type        = string
  default     = null
}

variable "iam_role_name_prefix" {
  description = "Name prefix for the IAM role"
  type        = string
  default     = null
}

variable "iam_role_description" {
  description = "Description of the IAM role"
  type        = string
  default     = null
}

variable "iam_role_path" {
  description = "Path to the IAM role"
  type        = string
  default     = "/"
}

variable "iam_role_max_session_duration" {
  description = "Maximum session duration for the IAM role"
  type        = number
  default     = 3600
}

variable "iam_role_permissions_boundary" {
  description = "Permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "iam_role_force_detach_policies" {
  description = "Whether to force detach policies when deleting the role"
  type        = bool
  default     = false
}

variable "iam_instance_profile_name_prefix" {
  description = "Name prefix for the IAM instance profile"
  type        = string
  default     = null
}

variable "iam_instance_profile_path" {
  description = "Path to the IAM instance profile"
  type        = string
  default     = "/"
}

variable "iam_policy_statements" {
  description = "List of IAM policy statements for the EC2 role"
  type = list(object({
    Effect    = string
    Action    = list(string)
    Resource  = list(string)
    Condition = map(any)
    Sid       = string
    Principal = map(any)
  }))
  default = []
}

variable "iam_role_tags" {
  description = "Additional tags for the IAM role"
  type        = map(string)
  default     = {}
}

variable "iam_instance_profile_tags" {
  description = "Additional tags for the IAM instance profile"
  type        = map(string)
  default     = {}
}

# Launch Template Configuration
variable "use_launch_template" {
  description = "Whether to use a launch template instead of direct EC2 instance"
  type        = bool
  default     = false
}

variable "launch_template_name" {
  description = "Name of the launch template (if not provided, will use name_prefix)"
  type        = string
  default     = null
}

variable "launch_template_name_prefix" {
  description = "Name prefix for the launch template"
  type        = string
  default     = null
}

variable "launch_template_description" {
  description = "Description of the launch template"
  type        = string
  default     = null
}

variable "launch_template_update_default_version" {
  description = "Whether to update the default version of the launch template"
  type        = bool
  default     = true
}

variable "launch_template_disable_api_stop" {
  description = "Whether to disable API stop for the launch template"
  type        = bool
  default     = false
}

variable "launch_template_disable_api_termination" {
  description = "Whether to disable API termination for the launch template"
  type        = bool
  default     = false
}

variable "launch_template_instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the launch template"
  type        = string
  default     = "stop"

  validation {
    condition     = contains(["stop", "terminate"], var.launch_template_instance_initiated_shutdown_behavior)
    error_message = "Shutdown behavior must be either 'stop' or 'terminate'."
  }
}

variable "launch_template_kernel_id" {
  description = "Kernel ID for the launch template"
  type        = string
  default     = null
}

variable "launch_template_ram_disk_id" {
  description = "RAM disk ID for the launch template"
  type        = string
  default     = null
}

variable "launch_template_instance_requirements" {
  description = "Instance requirements for the launch template"
  type = object({
    accelerator_count = object({
      min = number
      max = number
    })
    accelerator_manufacturers = list(string)
    accelerator_names = list(string)
    accelerator_total_memory_mib = object({
      min = number
      max = number
    })
    accelerator_types = list(string)
    allowed_instance_types = list(string)
    bare_metal = string
    baseline_ebs_bandwidth_mbps = object({
      min = number
      max = number
    })
    burstable_performance = string
    cpu_manufacturers = list(string)
    excluded_instance_types = list(string)
    instance_generations = list(string)
    local_storage = string
    local_storage_types = list(string)
    max_spot_price_as_percentage_of_optimal_on_demand_price = number
    memory_gib_per_vcpu = object({
      min = number
      max = number
    })
    memory_mib = object({
      min = number
      max = number
    })
    network_bandwidth_gbps = object({
      min = number
      max = number
    })
    network_interface_count = object({
      min = number
      max = number
    })
    on_demand_max_price_percentage_over_lowest_price = number
    require_hibernate_support = bool
    spot_max_price_percentage_over_lowest_price = number
    total_local_storage_gb = object({
      min = number
      max = number
    })
    vcpu_count = object({
      min = number
      max = number
    })
  })
  default = null
}

variable "launch_template_license_specification" {
  description = "License specification for the launch template"
  type = list(object({
    license_configuration_arn = string
  }))
  default = []
}

variable "launch_template_maintenance_options" {
  description = "Maintenance options for the launch template"
  type = object({
    auto_recovery = string
  })
  default = null
}

variable "launch_template_private_dns_name_options" {
  description = "Private DNS name options for the launch template"
  type = object({
    enable_resource_name_dns_aaaa_record = bool
    enable_resource_name_dns_a_record    = bool
    hostname_type                        = string
  })
  default = null
}

variable "block_device_mappings" {
  description = "List of block device mappings for the launch template"
  type = list(object({
    device_name = string
    no_device   = bool
    virtual_name = string
    ebs = object({
      delete_on_termination = bool
      encrypted             = bool
      iops                  = number
      kms_key_id            = string
      snapshot_id           = string
      throughput            = number
      volume_size           = number
      volume_type           = string
    })
  }))
  default = []
}

variable "network_interfaces" {
  description = "List of network interfaces for the launch template"
  type = list(object({
    associate_public_ip_address = bool
    delete_on_termination       = bool
    description                 = string
    device_index                = number
    network_interface_id        = string
    private_ip_address          = string
    subnet_id                   = string
    groups                      = list(string)
    ipv4_prefix_count           = number
    ipv4_prefixes               = list(string)
    ipv6_address_count          = number
    ipv6_addresses              = list(string)
    ipv6_prefix_count           = number
    ipv6_prefixes               = list(string)
    network_card_index          = number
    primary_private_ip_address  = string
    secondary_private_ip_address_count = number
    secondary_private_ip_addresses    = list(string)
  }))
  default = []
}

# User Data Configuration
variable "user_data" {
  description = "User data script for the EC2 instance"
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  description = "Whether to replace the instance when user data changes"
  type        = bool
  default     = false
}

# Block Device Configuration
variable "root_block_device" {
  description = "Root block device configuration"
  type = list(object({
    delete_on_termination = bool
    encrypted             = bool
    iops                  = number
    kms_key_id            = string
    volume_size           = number
    volume_type           = string
    throughput            = number
  }))
  default = [
    {
      delete_on_termination = true
      encrypted             = true
      iops                  = null
      kms_key_id            = null
      volume_size           = 20
      volume_type           = "gp3"
      throughput            = null
    }
  ]
}

variable "ebs_block_device" {
  description = "List of EBS block devices"
  type = list(object({
    delete_on_termination = bool
    device_name           = string
    encrypted             = bool
    iops                  = number
    kms_key_id            = string
    snapshot_id           = string
    volume_size           = number
    volume_type           = string
    throughput            = number
  }))
  default = []
}

variable "ephemeral_block_device" {
  description = "List of ephemeral block devices"
  type = list(object({
    device_name  = string
    no_device    = bool
    virtual_name = string
  }))
  default = []
}

# Monitoring Configuration
variable "enable_detailed_monitoring" {
  description = "Whether to enable detailed monitoring"
  type        = bool
  default     = false
}

# Metadata Configuration
variable "metadata_options" {
  description = "Metadata options for the EC2 instance"
  type = object({
    http_endpoint               = string
    http_tokens                 = string
    http_put_response_hop_limit = number
    instance_metadata_tags      = string
  })
  default = null
}

# Instance Configuration
variable "source_dest_check" {
  description = "Whether to enable source/destination check"
  type        = bool
  default     = true
}

variable "disable_api_termination" {
  description = "Whether to disable API termination"
  type        = bool
  default     = false
}

variable "disable_api_stop" {
  description = "Whether to disable API stop"
  type        = bool
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance"
  type        = string
  default     = "stop"

  validation {
    condition     = contains(["stop", "terminate"], var.instance_initiated_shutdown_behavior)
    error_message = "Shutdown behavior must be either 'stop' or 'terminate'."
  }
}

variable "placement_group" {
  description = "Placement group for the instance"
  type        = string
  default     = null
}

variable "create_placement_group" {
  description = "Whether to create a placement group"
  type        = bool
  default     = false
}

variable "placement_group_name" {
  description = "Name of the placement group"
  type        = string
  default     = null
}

variable "placement_group_strategy" {
  description = "Strategy for the placement group"
  type        = string
  default     = "cluster"

  validation {
    condition     = contains(["cluster", "partition", "spread"], var.placement_group_strategy)
    error_message = "Placement group strategy must be one of: cluster, partition, spread."
  }
}

variable "placement_group_partition_count" {
  description = "Number of partitions for the placement group"
  type        = number
  default     = null
}

variable "placement_group_tags" {
  description = "Tags for the placement group"
  type        = map(string)
  default     = {}
}

variable "tenancy" {
  description = "Tenancy of the instance"
  type        = string
  default     = "default"

  validation {
    condition     = contains(["default", "dedicated"], var.tenancy)
    error_message = "Tenancy must be either 'default' or 'dedicated'."
  }
}

variable "host_id" {
  description = "Host ID for the instance"
  type        = string
  default     = null
}

variable "cpu_core_count" {
  description = "Number of CPU cores for the instance"
  type        = number
  default     = null
}

variable "cpu_threads_per_core" {
  description = "Number of CPU threads per core"
  type        = number
  default     = null
}

variable "hibernation" {
  description = "Whether to enable hibernation"
  type        = bool
  default     = false
}

# Capacity Reservation Configuration
variable "capacity_reservation_preference" {
  description = "Capacity reservation preference"
  type        = string
  default     = "open"

  validation {
    condition     = contains(["open", "none"], var.capacity_reservation_preference)
    error_message = "Capacity reservation preference must be either 'open' or 'none'."
  }
}

variable "capacity_reservation_target" {
  description = "Capacity reservation target"
  type = object({
    capacity_reservation_id = string
  })
  default = null
}

# Spot Instance Configuration
variable "spot_price" {
  description = "Maximum price to pay for spot instances"
  type        = string
  default     = null
}

variable "spot_type" {
  description = "Type of spot request"
  type        = string
  default     = "one-time"

  validation {
    condition     = contains(["one-time", "persistent"], var.spot_type)
    error_message = "Spot type must be either 'one-time' or 'persistent'."
  }
}

variable "spot_launch_group" {
  description = "Launch group for spot instances"
  type        = string
  default     = null
}

variable "spot_block_duration_minutes" {
  description = "Block duration in minutes for spot instances"
  type        = number
  default     = null
}

variable "spot_valid_from" {
  description = "Valid from time for spot instances"
  type        = string
  default     = null
}

variable "spot_valid_until" {
  description = "Valid until time for spot instances"
  type        = string
  default     = null
}

variable "spot_instance_interruption_behavior" {
  description = "Behavior when spot instance is interrupted"
  type        = string
  default     = "terminate"

  validation {
    condition     = contains(["hibernate", "stop", "terminate"], var.spot_instance_interruption_behavior)
    error_message = "Spot instance interruption behavior must be one of: hibernate, stop, terminate."
  }
}

# Auto Scaling Group Configuration
variable "create_autoscaling_group" {
  description = "Whether to create an Auto Scaling Group"
  type        = bool
  default     = false
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group (if not provided, will use name_prefix)"
  type        = string
  default     = null
}

variable "asg_name_prefix" {
  description = "Name prefix for the Auto Scaling Group"
  type        = string
  default     = null
}

variable "asg_desired_capacity" {
  description = "Desired capacity for the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum size for the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "asg_min_size" {
  description = "Minimum size for the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_health_check_grace_period" {
  description = "Health check grace period for the Auto Scaling Group"
  type        = number
  default     = 300
}

variable "asg_health_check_type" {
  description = "Health check type for the Auto Scaling Group"
  type        = string
  default     = "EC2"

  validation {
    condition     = contains(["EC2", "ELB"], var.asg_health_check_type)
    error_message = "Health check type must be either 'EC2' or 'ELB'."
  }
}

variable "asg_subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
  default     = []
}

variable "asg_tags" {
  description = "Tags for the Auto Scaling Group"
  type = list(object({
    key                 = string
    value               = string
    propagate_at_launch = bool
  }))
  default = []
}

variable "target_group_arns" {
  description = "List of target group ARNs for the Auto Scaling Group"
  type        = list(string)
  default     = []
}

variable "load_balancers" {
  description = "List of load balancer names for the Auto Scaling Group"
  type        = list(string)
  default     = []
}

variable "service_linked_role_arn" {
  description = "Service linked role ARN for the Auto Scaling Group"
  type        = string
  default     = null
}

variable "max_instance_lifetime" {
  description = "Maximum instance lifetime for the Auto Scaling Group"
  type        = number
  default     = null
}

variable "capacity_rebalance" {
  description = "Whether to enable capacity rebalancing"
  type        = bool
  default     = false
}

# Warm Pool Configuration
variable "warm_pool_state" {
  description = "State of the warm pool"
  type        = string
  default     = "Stopped"

  validation {
    condition     = contains(["Stopped", "Running"], var.warm_pool_state)
    error_message = "Warm pool state must be either 'Stopped' or 'Running'."
  }
}

variable "warm_pool_min_size" {
  description = "Minimum size for the warm pool"
  type        = number
  default     = 0
}

variable "warm_pool_max_group_prepared_capacity" {
  description = "Maximum group prepared capacity for the warm pool"
  type        = number
  default     = null
}

# Mixed Instances Policy Configuration
variable "mixed_instances_policy" {
  description = "Mixed instances policy for the Auto Scaling Group"
  type = object({
    instances_distribution = object({
      on_demand_base_capacity                  = number
      on_demand_percentage_above_base_capacity = number
      on_demand_allocation_strategy            = string
      spot_allocation_strategy                 = string
      spot_instance_pools                      = number
      spot_max_price                           = string
    })
    override = list(object({
      instance_type     = string
      weighted_capacity = number
      launch_template_specification = object({
        launch_template_id   = string
        launch_template_name = string
        version              = string
      })
    }))
  })
  default = null
}

# Instance Refresh Configuration
variable "instance_refresh" {
  description = "Instance refresh configuration for the Auto Scaling Group"
  type = object({
    strategy = string
    preferences = object({
      min_healthy_percentage = number
      max_healthy_percentage = number
      instance_warmup        = number
      checkpoint_percentages = list(number)
      checkpoint_delay       = number
      auto_rollback          = bool
      scale_in_protected_instances = string
      standby_instances      = string
    })
  })
  default = null
}

# Auto Scaling Policy Configuration
variable "asg_policies" {
  description = "Auto Scaling policies"
  type = map(object({
    name = string
    adjustment_type = string
    scaling_adjustment = number
    cooldown = number
    metric_aggregation_type = string
    min_adjustment_magnitude = number
    step_adjustment = list(object({
      metric_interval_lower_bound = number
      metric_interval_upper_bound = number
      scaling_adjustment          = number
    }))
    target_tracking_configuration = object({
      predefined_metric_type = string
      resource_label         = string
      target_value           = number
      disable_scale_in       = bool
    })
  }))
  default = {}
}

# CloudWatch Alarm Configuration
variable "cloudwatch_alarms" {
  description = "CloudWatch alarms for the Auto Scaling Group"
  type = map(object({
    alarm_name = string
    comparison_operator = string
    evaluation_periods = number
    metric_name = string
    namespace = string
    period = number
    statistic = string
    threshold = number
    alarm_description = string
    alarm_actions = list(string)
    ok_actions = list(string)
    insufficient_data_actions = list(string)
    dimensions = list(object({
      name  = string
      value = string
    }))
  }))
  default = {}
}

# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      for key, value in var.tags : length(key) > 0 && length(key) <= 128
    ])
    error_message = "Tag keys must be between 1 and 128 characters."
  }
} 