# EC2 Instance Outputs
output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.ec2[*].id
}

output "instance_public_ips" {
  description = "List of public IP addresses of the EC2 instances"
  value       = aws_instance.ec2[*].public_ip
}

output "instance_private_ips" {
  description = "List of private IP addresses of the EC2 instances"
  value       = aws_instance.ec2[*].private_ip
}

output "instance_public_dns" {
  description = "List of public DNS names of the EC2 instances"
  value       = aws_instance.ec2[*].public_dns
}

output "instance_private_dns" {
  description = "List of private DNS names of the EC2 instances"
  value       = aws_instance.ec2[*].private_dns
}

output "instance_arns" {
  description = "List of ARNs of the EC2 instances"
  value       = aws_instance.ec2[*].arn
}

output "instance_key_names" {
  description = "List of key pair names used by the EC2 instances"
  value       = aws_instance.ec2[*].key_name
}

output "instance_subnet_ids" {
  description = "List of subnet IDs where the EC2 instances are located"
  value       = aws_instance.ec2[*].subnet_id
}

output "instance_vpc_security_group_ids" {
  description = "List of VPC security group IDs attached to the EC2 instances"
  value       = aws_instance.ec2[*].vpc_security_group_ids
}

output "instance_iam_instance_profiles" {
  description = "List of IAM instance profile names attached to the EC2 instances"
  value       = aws_instance.ec2[*].iam_instance_profile
}

output "instance_root_block_devices" {
  description = "List of root block device configurations for the EC2 instances"
  value       = aws_instance.ec2[*].root_block_device
}

output "instance_ebs_block_devices" {
  description = "List of EBS block device configurations for the EC2 instances"
  value       = aws_instance.ec2[*].ebs_block_device
}

output "instance_ephemeral_block_devices" {
  description = "List of ephemeral block device configurations for the EC2 instances"
  value       = aws_instance.ec2[*].ephemeral_block_device
}

output "instance_metadata_options" {
  description = "List of metadata options for the EC2 instances"
  value       = aws_instance.ec2[*].metadata_options
}

output "instance_network_interfaces" {
  description = "List of network interface configurations for the EC2 instances"
  value       = aws_instance.ec2[*].network_interface
}

output "instance_placement_groups" {
  description = "List of placement groups for the EC2 instances"
  value       = aws_instance.ec2[*].placement_group
}

output "instance_tenancies" {
  description = "List of tenancy configurations for the EC2 instances"
  value       = aws_instance.ec2[*].tenancy
}

output "instance_host_ids" {
  description = "List of host IDs for the EC2 instances"
  value       = aws_instance.ec2[*].host_id
}

output "instance_cpu_core_counts" {
  description = "List of CPU core counts for the EC2 instances"
  value       = aws_instance.ec2[*].cpu_core_count
}

output "instance_cpu_threads_per_cores" {
  description = "List of CPU threads per core for the EC2 instances"
  value       = aws_instance.ec2[*].cpu_threads_per_core
}

output "instance_hibernations" {
  description = "List of hibernation configurations for the EC2 instances"
  value       = aws_instance.ec2[*].hibernation
}

output "instance_capacity_reservation_specifications" {
  description = "List of capacity reservation specifications for the EC2 instances"
  value       = aws_instance.ec2[*].capacity_reservation_specification
}

output "instance_source_dest_checks" {
  description = "List of source/destination check configurations for the EC2 instances"
  value       = aws_instance.ec2[*].source_dest_check
}

output "instance_disable_api_terminations" {
  description = "List of API termination disable configurations for the EC2 instances"
  value       = aws_instance.ec2[*].disable_api_termination
}

output "instance_disable_api_stops" {
  description = "List of API stop disable configurations for the EC2 instances"
  value       = aws_instance.ec2[*].disable_api_stop
}

output "instance_initiated_shutdown_behaviors" {
  description = "List of instance initiated shutdown behaviors for the EC2 instances"
  value       = aws_instance.ec2[*].instance_initiated_shutdown_behavior
}

output "instance_monitorings" {
  description = "List of monitoring configurations for the EC2 instances"
  value       = aws_instance.ec2[*].monitoring
}

output "instance_tags" {
  description = "List of tags for the EC2 instances"
  value       = aws_instance.ec2[*].tags
}

# Placement Group Outputs
output "placement_group_id" {
  description = "ID of the placement group created for the EC2 instance"
  value       = var.create_placement_group ? aws_placement_group.ec2[0].id : null
}

output "placement_group_name" {
  description = "Name of the placement group created for the EC2 instance"
  value       = var.create_placement_group ? aws_placement_group.ec2[0].name : null
}

output "placement_group_arn" {
  description = "ARN of the placement group created for the EC2 instance"
  value       = var.create_placement_group ? aws_placement_group.ec2[0].arn : null
}

output "placement_group_strategy" {
  description = "Strategy of the placement group created for the EC2 instance"
  value       = var.create_placement_group ? aws_placement_group.ec2[0].strategy : null
}

output "placement_group_tags" {
  description = "Tags of the placement group created for the EC2 instance"
  value       = var.create_placement_group ? aws_placement_group.ec2[0].tags : null
}

# Security Group Outputs
output "security_group_id" {
  description = "ID of the security group created for the EC2 instance"
  value       = var.create_security_group ? aws_security_group.ec2[0].id : null
}

output "security_group_name" {
  description = "Name of the security group created for the EC2 instance"
  value       = var.create_security_group ? aws_security_group.ec2[0].name : null
}

output "security_group_arn" {
  description = "ARN of the security group created for the EC2 instance"
  value       = var.create_security_group ? aws_security_group.ec2[0].arn : null
}

output "security_group_description" {
  description = "Description of the security group created for the EC2 instance"
  value       = var.create_security_group ? aws_security_group.ec2[0].description : null
}

output "security_group_vpc_id" {
  description = "VPC ID of the security group created for the EC2 instance"
  value       = var.create_security_group ? aws_security_group.ec2[0].vpc_id : null
}

output "security_group_owner_id" {
  description = "Owner ID of the security group created for the EC2 instance"
  value       = var.create_security_group ? aws_security_group.ec2[0].owner_id : null
}

output "security_group_ingress" {
  description = "Ingress rules of the security group created for the EC2 instance"
  value       = var.create_security_group ? aws_security_group.ec2[0].ingress : null
}

output "security_group_egress" {
  description = "Egress rules of the security group created for the EC2 instance"
  value       = var.create_security_group ? aws_security_group.ec2[0].egress : null
}

output "security_group_tags" {
  description = "Tags of the security group created for the EC2 instance"
  value       = var.create_security_group ? aws_security_group.ec2[0].tags : null
}

# Key Pair Outputs
output "key_pair_id" {
  description = "ID of the key pair created for the EC2 instance"
  value       = var.create_key_pair ? aws_key_pair.ec2[0].id : null
}

output "key_pair_name" {
  description = "Name of the key pair created for the EC2 instance"
  value       = var.create_key_pair ? aws_key_pair.ec2[0].key_name : null
}

output "key_pair_fingerprint" {
  description = "Fingerprint of the key pair created for the EC2 instance"
  value       = var.create_key_pair ? aws_key_pair.ec2[0].fingerprint : null
}

output "key_pair_tags" {
  description = "Tags of the key pair created for the EC2 instance"
  value       = var.create_key_pair ? aws_key_pair.ec2[0].tags : null
}

# IAM Role Outputs
output "iam_role_id" {
  description = "ID of the IAM role created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_role.ec2[0].id : null
}

output "iam_role_name" {
  description = "Name of the IAM role created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_role.ec2[0].name : null
}

output "iam_role_arn" {
  description = "ARN of the IAM role created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_role.ec2[0].arn : null
}

output "iam_role_unique_id" {
  description = "Unique ID of the IAM role created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_role.ec2[0].unique_id : null
}

output "iam_role_create_date" {
  description = "Creation date of the IAM role created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_role.ec2[0].create_date : null
}

output "iam_role_description" {
  description = "Description of the IAM role created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_role.ec2[0].description : null
}

output "iam_role_path" {
  description = "Path of the IAM role created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_role.ec2[0].path : null
}

output "iam_role_max_session_duration" {
  description = "Maximum session duration of the IAM role created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_role.ec2[0].max_session_duration : null
}

output "iam_role_permissions_boundary" {
  description = "Permissions boundary of the IAM role created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_role.ec2[0].permissions_boundary : null
}

output "iam_role_tags" {
  description = "Tags of the IAM role created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_role.ec2[0].tags : null
}

# IAM Instance Profile Outputs
output "iam_instance_profile_id" {
  description = "ID of the IAM instance profile created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_instance_profile.ec2[0].id : null
}

output "iam_instance_profile_name" {
  description = "Name of the IAM instance profile created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_instance_profile.ec2[0].name : null
}

output "iam_instance_profile_arn" {
  description = "ARN of the IAM instance profile created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_instance_profile.ec2[0].arn : null
}

output "iam_instance_profile_role" {
  description = "Role name of the IAM instance profile created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_instance_profile.ec2[0].role : null
}

output "iam_instance_profile_path" {
  description = "Path of the IAM instance profile created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_instance_profile.ec2[0].path : null
}

output "iam_instance_profile_tags" {
  description = "Tags of the IAM instance profile created for the EC2 instance"
  value       = var.create_iam_role ? aws_iam_instance_profile.ec2[0].tags : null
}

# IAM Policy Outputs
output "iam_policy_id" {
  description = "ID of the IAM policy created for the EC2 instance"
  value       = var.create_iam_role && length(var.iam_policy_statements) > 0 ? aws_iam_role_policy.ec2[0].id : null
}

output "iam_policy_name" {
  description = "Name of the IAM policy created for the EC2 instance"
  value       = var.create_iam_role && length(var.iam_policy_statements) > 0 ? aws_iam_role_policy.ec2[0].name : null
}

output "iam_policy_role" {
  description = "Role name of the IAM policy created for the EC2 instance"
  value       = var.create_iam_role && length(var.iam_policy_statements) > 0 ? aws_iam_role_policy.ec2[0].role : null
}

output "iam_policy_policy" {
  description = "Policy document of the IAM policy created for the EC2 instance"
  value       = var.create_iam_role && length(var.iam_policy_statements) > 0 ? aws_iam_role_policy.ec2[0].policy : null
}

# Launch Template Outputs
output "launch_template_id" {
  description = "ID of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].id : null
}

output "launch_template_name" {
  description = "Name of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].name : null
}

output "launch_template_arn" {
  description = "ARN of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].arn : null
}

output "launch_template_latest_version" {
  description = "Latest version of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].latest_version : null
}

output "launch_template_default_version" {
  description = "Default version of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].default_version : null
}

output "launch_template_image_id" {
  description = "Image ID of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].image_id : null
}

output "launch_template_instance_type" {
  description = "Instance type of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].instance_type : null
}

output "launch_template_key_name" {
  description = "Key name of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].key_name : null
}

output "launch_template_vpc_security_group_ids" {
  description = "VPC security group IDs of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].vpc_security_group_ids : null
}

output "launch_template_iam_instance_profile" {
  description = "IAM instance profile of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].iam_instance_profile : null
}

output "launch_template_block_device_mappings" {
  description = "Block device mappings of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].block_device_mappings : null
}

output "launch_template_network_interfaces" {
  description = "Network interfaces of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].network_interfaces : null
}

output "launch_template_user_data" {
  description = "User data of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].user_data : null
}

output "launch_template_metadata_options" {
  description = "Metadata options of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].metadata_options : null
}

output "launch_template_monitoring" {
  description = "Monitoring configuration of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].monitoring : null
}

output "launch_template_tag_specifications" {
  description = "Tag specifications of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].tag_specifications : null
}

output "launch_template_tags" {
  description = "Tags of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].tags : null
}

output "launch_template_description" {
  description = "Description of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].description : null
}

output "launch_template_disable_api_stop" {
  description = "Disable API stop setting of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].disable_api_stop : null
}

output "launch_template_disable_api_termination" {
  description = "Disable API termination setting of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].disable_api_termination : null
}

output "launch_template_instance_initiated_shutdown_behavior" {
  description = "Instance initiated shutdown behavior of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].instance_initiated_shutdown_behavior : null
}

output "launch_template_kernel_id" {
  description = "Kernel ID of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].kernel_id : null
}

output "launch_template_ram_disk_id" {
  description = "RAM disk ID of the launch template created for the EC2 instance"
  value       = var.use_launch_template ? aws_launch_template.ec2[0].ram_disk_id : null
}

# Auto Scaling Group Outputs
output "autoscaling_group_id" {
  description = "ID of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].id : null
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].name : null
}

output "autoscaling_group_arn" {
  description = "ARN of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].arn : null
}

output "autoscaling_group_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].desired_capacity : null
}

output "autoscaling_group_max_size" {
  description = "Maximum size of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].max_size : null
}

output "autoscaling_group_min_size" {
  description = "Minimum size of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].min_size : null
}

output "autoscaling_group_health_check_grace_period" {
  description = "Health check grace period of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].health_check_grace_period : null
}

output "autoscaling_group_health_check_type" {
  description = "Health check type of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].health_check_type : null
}

output "autoscaling_group_vpc_zone_identifier" {
  description = "VPC zone identifier of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].vpc_zone_identifier : null
}

output "autoscaling_group_launch_template" {
  description = "Launch template configuration of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].launch_template : null
}

output "autoscaling_group_tags" {
  description = "Tags of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].tags : null
}

output "autoscaling_group_target_group_arns" {
  description = "Target group ARNs of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].target_group_arns : null
}

output "autoscaling_group_load_balancers" {
  description = "Load balancers of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].load_balancers : null
}

output "autoscaling_group_placement_group" {
  description = "Placement group of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].placement_group : null
}

output "autoscaling_group_service_linked_role_arn" {
  description = "Service linked role ARN of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].service_linked_role_arn : null
}

output "autoscaling_group_max_instance_lifetime" {
  description = "Maximum instance lifetime of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].max_instance_lifetime : null
}

output "autoscaling_group_capacity_rebalance" {
  description = "Capacity rebalance configuration of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].capacity_rebalance : null
}

output "autoscaling_group_warm_pool" {
  description = "Warm pool configuration of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].warm_pool : null
}

output "autoscaling_group_mixed_instances_policy" {
  description = "Mixed instances policy of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].mixed_instances_policy : null
}

output "autoscaling_group_instance_refresh" {
  description = "Instance refresh configuration of the Auto Scaling Group created for the EC2 instance"
  value       = var.create_autoscaling_group ? aws_autoscaling_group.ec2[0].instance_refresh : null
}

# Auto Scaling Policy Outputs
output "autoscaling_policy_ids" {
  description = "IDs of the Auto Scaling policies created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.asg_policies) > 0 ? [for policy in aws_autoscaling_policy.ec2 : policy.id] : []
}

output "autoscaling_policy_names" {
  description = "Names of the Auto Scaling policies created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.asg_policies) > 0 ? [for policy in aws_autoscaling_policy.ec2 : policy.name] : []
}

output "autoscaling_policy_arns" {
  description = "ARNs of the Auto Scaling policies created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.asg_policies) > 0 ? [for policy in aws_autoscaling_policy.ec2 : policy.arn] : []
}

output "autoscaling_policy_adjustment_types" {
  description = "Adjustment types of the Auto Scaling policies created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.asg_policies) > 0 ? [for policy in aws_autoscaling_policy.ec2 : policy.adjustment_type] : []
}

output "autoscaling_policy_scaling_adjustments" {
  description = "Scaling adjustments of the Auto Scaling policies created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.asg_policies) > 0 ? [for policy in aws_autoscaling_policy.ec2 : policy.scaling_adjustment] : []
}

output "autoscaling_policy_cooldowns" {
  description = "Cooldowns of the Auto Scaling policies created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.asg_policies) > 0 ? [for policy in aws_autoscaling_policy.ec2 : policy.cooldown] : []
}

output "autoscaling_policy_metric_aggregation_types" {
  description = "Metric aggregation types of the Auto Scaling policies created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.asg_policies) > 0 ? [for policy in aws_autoscaling_policy.ec2 : policy.metric_aggregation_type] : []
}

output "autoscaling_policy_min_adjustment_magnitudes" {
  description = "Minimum adjustment magnitudes of the Auto Scaling policies created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.asg_policies) > 0 ? [for policy in aws_autoscaling_policy.ec2 : policy.min_adjustment_magnitude] : []
}

output "autoscaling_policy_step_adjustments" {
  description = "Step adjustments of the Auto Scaling policies created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.asg_policies) > 0 ? [for policy in aws_autoscaling_policy.ec2 : policy.step_adjustment] : []
}

output "autoscaling_policy_target_tracking_configurations" {
  description = "Target tracking configurations of the Auto Scaling policies created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.asg_policies) > 0 ? [for policy in aws_autoscaling_policy.ec2 : policy.target_tracking_configuration] : []
}

# CloudWatch Alarm Outputs
output "cloudwatch_alarm_ids" {
  description = "IDs of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.id] : []
}

output "cloudwatch_alarm_names" {
  description = "Names of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.alarm_name] : []
}

output "cloudwatch_alarm_arns" {
  description = "ARNs of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.arn] : []
}

output "cloudwatch_alarm_comparison_operators" {
  description = "Comparison operators of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.comparison_operator] : []
}

output "cloudwatch_alarm_evaluation_periods" {
  description = "Evaluation periods of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.evaluation_periods] : []
}

output "cloudwatch_alarm_metric_names" {
  description = "Metric names of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.metric_name] : []
}

output "cloudwatch_alarm_namespaces" {
  description = "Namespaces of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.namespace] : []
}

output "cloudwatch_alarm_periods" {
  description = "Periods of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.period] : []
}

output "cloudwatch_alarm_statistics" {
  description = "Statistics of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.statistic] : []
}

output "cloudwatch_alarm_thresholds" {
  description = "Thresholds of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.threshold] : []
}

output "cloudwatch_alarm_descriptions" {
  description = "Descriptions of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.alarm_description] : []
}

output "cloudwatch_alarm_actions" {
  description = "Alarm actions of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.alarm_actions] : []
}

output "cloudwatch_alarm_ok_actions" {
  description = "OK actions of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.ok_actions] : []
}

output "cloudwatch_alarm_insufficient_data_actions" {
  description = "Insufficient data actions of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.insufficient_data_actions] : []
}

output "cloudwatch_alarm_dimensions" {
  description = "Dimensions of the CloudWatch alarms created for the EC2 instance"
  value       = var.create_autoscaling_group && length(var.cloudwatch_alarms) > 0 ? [for alarm in aws_cloudwatch_metric_alarm.ec2 : alarm.dimensions] : []
}

# AMI Outputs
output "ami_id" {
  description = "AMI ID used for the EC2 instance"
  value       = local.ami_id
}

output "amazon_linux_2_ami_id" {
  description = "Amazon Linux 2 AMI ID"
  value       = var.use_latest_ami ? data.aws_ami.amazon_linux_2[0].id : null
}

output "ubuntu_ami_id" {
  description = "Ubuntu AMI ID"
  value       = var.ami_type == "ubuntu" ? data.aws_ami.ubuntu[0].id : null
}

output "custom_ami_id" {
  description = "Custom AMI ID"
  value       = var.custom_ami_id != null ? data.aws_ami.custom[0].id : null
}

output "local_ami_id" {
  description = "Local AMI ID value"
  value       = local.ami_id
} 