# AWS EC2 Terraform Module

A comprehensive Terraform module for creating AWS EC2 instances with support for launch templates, Auto Scaling Groups, IAM roles, security groups, and more.

## Features

- **Multiple AMI Support**: Amazon Linux 2, Ubuntu, and custom AMIs
- **Launch Template Support**: Advanced instance configuration with launch templates
- **Auto Scaling Groups**: Complete ASG setup with policies and CloudWatch alarms
- **IAM Integration**: Automatic IAM role and instance profile creation
- **Security Groups**: Flexible ingress/egress rule configuration
- **Key Pair Management**: SSH key pair creation and management
- **Block Device Configuration**: Root, EBS, and ephemeral block devices
- **User Data Scripts**: Custom initialization scripts
- **Monitoring**: Detailed monitoring and metadata options
- **Tags**: Comprehensive resource tagging

## Usage

### Basic EC2 Instance

```hcl
module "ec2" {
  source = "./tfm-aws-ec2/tfm-aws-ec2"
  
  instance_name = "my-instance"
  instance_type = "t3.micro"
  subnet_id     = "subnet-12345678"
  
  use_latest_ami = true
  ami_type       = "amazon_linux_2"
  
  create_security_group = true
  vpc_id                = "vpc-12345678"
  
  associate_public_ip_address = true
  
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### EC2 Instance with Auto Scaling Group

```hcl
module "ec2_asg" {
  source = "./tfm-aws-ec2/tfm-aws-ec2"
  
  instance_name = "asg-instance"
  instance_type = "t3.micro"
  subnet_id     = "subnet-12345678"
  
  use_launch_template = true
  create_autoscaling_group = true
  
  asg_desired_capacity = 2
  asg_max_size         = 5
  asg_min_size         = 1
  asg_subnet_ids       = ["subnet-12345678", "subnet-87654321"]
  
  create_security_group = true
  vpc_id                = "vpc-12345678"
  
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### EC2 Instance with IAM Role

```hcl
module "ec2_iam" {
  source = "./tfm-aws-ec2/tfm-aws-ec2"
  
  instance_name = "iam-instance"
  instance_type = "t3.micro"
  subnet_id     = "subnet-12345678"
  
  create_iam_role = true
  iam_policy_statements = [
    {
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
      Resource = [
        "arn:aws:s3:::my-bucket",
        "arn:aws:s3:::my-bucket/*"
      ]
    }
  ]
  
  create_security_group = true
  vpc_id                = "vpc-12345678"
  
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Multiple EC2 Instances

```hcl
module "multiple_ec2" {
  source = "./tfm-aws-ec2/tfm-aws-ec2"
  
  instance_name = "multi-instance"
  instance_count = 3
  instance_type = "t3.micro"
  subnet_id     = "subnet-12345678"
  
  use_latest_ami = true
  ami_type       = "amazon_linux_2"
  
  create_security_group = true
  vpc_id                = "vpc-12345678"
  
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| instance_name | Name of the EC2 instance | `string` | `"ec2-instance"` | no |
| instance_count | Number of EC2 instances to create | `number` | `1` | no |
| instance_type | EC2 instance type | `string` | `"t3.micro"` | no |
| ami_id | AMI ID to use for the EC2 instance | `string` | `null` | no |
| use_latest_ami | Whether to use the latest Amazon Linux 2 AMI | `bool` | `true` | no |
| ami_type | Type of AMI to use (amazon_linux_2, ubuntu, custom) | `string` | `"amazon_linux_2"` | no |
| custom_ami_id | Custom AMI ID to use | `string` | `null` | no |
| custom_ami_owner | Owner of the custom AMI | `string` | `"self"` | no |
| vpc_id | VPC ID where the EC2 instance will be created | `string` | `null` | no |
| subnet_id | Subnet ID where the EC2 instance will be created | `string` | `null` | no |
| availability_zone | Availability zone for the EC2 instance | `string` | `null` | no |
| associate_public_ip_address | Whether to associate a public IP address | `bool` | `false` | no |
| private_ip | Private IP address for the EC2 instance | `string` | `null` | no |
| create_security_group | Whether to create a security group for the EC2 instance | `bool` | `true` | no |
| security_group_ids | List of security group IDs to attach to the EC2 instance | `list(string)` | `[]` | no |
| security_group_ingress_rules | List of ingress rules for the security group | `list(object)` | See variables.tf | no |
| security_group_egress_rules | List of egress rules for the security group | `list(object)` | See variables.tf | no |
| create_key_pair | Whether to create a key pair for SSH access | `bool` | `false` | no |
| key_name | Name of the key pair to use for SSH access | `string` | `null` | no |
| public_key | Public key for the key pair | `string` | `null` | no |
| create_iam_role | Whether to create an IAM role for the EC2 instance | `bool` | `false` | no |
| iam_instance_profile_name | Name of the IAM instance profile to use | `string` | `null` | no |
| iam_policy_statements | List of IAM policy statements for the EC2 role | `list(object)` | `[]` | no |
| use_launch_template | Whether to use a launch template instead of direct EC2 instance | `bool` | `false` | no |
| block_device_mappings | List of block device mappings for the launch template | `list(object)` | `[]` | no |
| network_interfaces | List of network interfaces for the launch template | `list(object)` | `[]` | no |
| user_data | User data script for the EC2 instance | `string` | `null` | no |
| user_data_replace_on_change | Whether to replace the instance when user data changes | `bool` | `false` | no |
| root_block_device | Root block device configuration | `list(object)` | See variables.tf | no |
| ebs_block_device | List of EBS block devices | `list(object)` | `[]` | no |
| ephemeral_block_device | List of ephemeral block devices | `list(object)` | `[]` | no |
| enable_detailed_monitoring | Whether to enable detailed monitoring | `bool` | `false` | no |
| metadata_options | Metadata options for the EC2 instance | `object` | `null` | no |
| source_dest_check | Whether to enable source/destination check | `bool` | `true` | no |
| disable_api_termination | Whether to disable API termination | `bool` | `false` | no |
| instance_initiated_shutdown_behavior | Shutdown behavior for the instance | `string` | `"stop"` | no |
| placement_group | Placement group for the instance | `string` | `null` | no |
| tenancy | Tenancy of the instance | `string` | `"default"` | no |
| host_id | Host ID for the instance | `string` | `null` | no |
| cpu_core_count | Number of CPU cores for the instance | `number` | `null` | no |
| cpu_threads_per_core | Number of CPU threads per core | `number` | `null` | no |
| hibernation | Whether to enable hibernation | `bool` | `false` | no |
| capacity_reservation_preference | Capacity reservation preference | `string` | `"open"` | no |
| capacity_reservation_target | Capacity reservation target | `object` | `null` | no |
| create_autoscaling_group | Whether to create an Auto Scaling Group | `bool` | `false` | no |
| asg_desired_capacity | Desired capacity for the Auto Scaling Group | `number` | `1` | no |
| asg_max_size | Maximum size for the Auto Scaling Group | `number` | `3` | no |
| asg_min_size | Minimum size for the Auto Scaling Group | `number` | `1` | no |
| asg_health_check_grace_period | Health check grace period for the Auto Scaling Group | `number` | `300` | no |
| asg_health_check_type | Health check type for the Auto Scaling Group | `string` | `"EC2"` | no |
| asg_subnet_ids | List of subnet IDs for the Auto Scaling Group | `list(string)` | `[]` | no |
| asg_tags | Tags for the Auto Scaling Group | `list(object)` | `[]` | no |
| target_group_arns | List of target group ARNs for the Auto Scaling Group | `list(string)` | `[]` | no |
| load_balancers | List of load balancer names for the Auto Scaling Group | `list(string)` | `[]` | no |
| service_linked_role_arn | Service linked role ARN for the Auto Scaling Group | `string` | `null` | no |
| max_instance_lifetime | Maximum instance lifetime for the Auto Scaling Group | `number` | `null` | no |
| capacity_rebalance | Whether to enable capacity rebalancing | `bool` | `false` | no |
| warm_pool_state | State of the warm pool | `string` | `"Stopped"` | no |
| warm_pool_min_size | Minimum size for the warm pool | `number` | `0` | no |
| warm_pool_max_group_prepared_capacity | Maximum group prepared capacity for the warm pool | `number` | `null` | no |
| mixed_instances_policy | Mixed instances policy for the Auto Scaling Group | `object` | `null` | no |
| instance_refresh | Instance refresh configuration for the Auto Scaling Group | `object` | `null` | no |
| asg_policies | Auto Scaling policies | `map(object)` | `{}` | no |
| cloudwatch_alarms | CloudWatch alarms for the Auto Scaling Group | `map(object)` | `{}` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_ids | List of EC2 instance IDs |
| instance_public_ips | List of public IP addresses of the EC2 instances |
| instance_private_ips | List of private IP addresses of the EC2 instances |
| instance_public_dns | List of public DNS names of the EC2 instances |
| instance_private_dns | List of private DNS names of the EC2 instances |
| instance_arns | List of ARNs of the EC2 instances |
| instance_key_names | List of key pair names used by the EC2 instances |
| instance_subnet_ids | List of subnet IDs where the EC2 instances are located |
| instance_vpc_security_group_ids | List of VPC security group IDs attached to the EC2 instances |
| instance_iam_instance_profiles | List of IAM instance profile names attached to the EC2 instances |
| instance_root_block_devices | List of root block device configurations for the EC2 instances |
| instance_ebs_block_devices | List of EBS block device configurations for the EC2 instances |
| instance_ephemeral_block_devices | List of ephemeral block device configurations for the EC2 instances |
| instance_metadata_options | List of metadata options for the EC2 instances |
| instance_network_interfaces | List of network interface configurations for the EC2 instances |
| instance_placement_groups | List of placement groups for the EC2 instances |
| instance_tenancies | List of tenancy configurations for the EC2 instances |
| instance_host_ids | List of host IDs for the EC2 instances |
| instance_cpu_core_counts | List of CPU core counts for the EC2 instances |
| instance_cpu_threads_per_cores | List of CPU threads per core for the EC2 instances |
| instance_hibernations | List of hibernation configurations for the EC2 instances |
| instance_capacity_reservation_specifications | List of capacity reservation specifications for the EC2 instances |
| instance_source_dest_checks | List of source/destination check configurations for the EC2 instances |
| instance_disable_api_terminations | List of API termination disable configurations for the EC2 instances |
| instance_initiated_shutdown_behaviors | List of instance initiated shutdown behaviors for the EC2 instances |
| instance_monitorings | List of monitoring configurations for the EC2 instances |
| instance_tags | List of tags for the EC2 instances |
| security_group_id | ID of the security group created for the EC2 instance |
| security_group_name | Name of the security group created for the EC2 instance |
| security_group_arn | ARN of the security group created for the EC2 instance |
| security_group_description | Description of the security group created for the EC2 instance |
| security_group_vpc_id | VPC ID of the security group created for the EC2 instance |
| security_group_owner_id | Owner ID of the security group created for the EC2 instance |
| security_group_ingress | Ingress rules of the security group created for the EC2 instance |
| security_group_egress | Egress rules of the security group created for the EC2 instance |
| security_group_tags | Tags of the security group created for the EC2 instance |
| key_pair_id | ID of the key pair created for the EC2 instance |
| key_pair_name | Name of the key pair created for the EC2 instance |
| key_pair_fingerprint | Fingerprint of the key pair created for the EC2 instance |
| key_pair_tags | Tags of the key pair created for the EC2 instance |
| iam_role_id | ID of the IAM role created for the EC2 instance |
| iam_role_name | Name of the IAM role created for the EC2 instance |
| iam_role_arn | ARN of the IAM role created for the EC2 instance |
| iam_role_unique_id | Unique ID of the IAM role created for the EC2 instance |
| iam_role_create_date | Creation date of the IAM role created for the EC2 instance |
| iam_role_tags | Tags of the IAM role created for the EC2 instance |
| iam_instance_profile_id | ID of the IAM instance profile created for the EC2 instance |
| iam_instance_profile_name | Name of the IAM instance profile created for the EC2 instance |
| iam_instance_profile_arn | ARN of the IAM instance profile created for the EC2 instance |
| iam_instance_profile_role | Role name of the IAM instance profile created for the EC2 instance |
| iam_instance_profile_tags | Tags of the IAM instance profile created for the EC2 instance |
| iam_policy_id | ID of the IAM policy created for the EC2 instance |
| iam_policy_name | Name of the IAM policy created for the EC2 instance |
| iam_policy_role | Role name of the IAM policy created for the EC2 instance |
| iam_policy_policy | Policy document of the IAM policy created for the EC2 instance |
| launch_template_id | ID of the launch template created for the EC2 instance |
| launch_template_name | Name of the launch template created for the EC2 instance |
| launch_template_arn | ARN of the launch template created for the EC2 instance |
| launch_template_latest_version | Latest version of the launch template created for the EC2 instance |
| launch_template_default_version | Default version of the launch template created for the EC2 instance |
| launch_template_image_id | Image ID of the launch template created for the EC2 instance |
| launch_template_instance_type | Instance type of the launch template created for the EC2 instance |
| launch_template_key_name | Key name of the launch template created for the EC2 instance |
| launch_template_vpc_security_group_ids | VPC security group IDs of the launch template created for the EC2 instance |
| launch_template_iam_instance_profile | IAM instance profile of the launch template created for the EC2 instance |
| launch_template_block_device_mappings | Block device mappings of the launch template created for the EC2 instance |
| launch_template_network_interfaces | Network interfaces of the launch template created for the EC2 instance |
| launch_template_user_data | User data of the launch template created for the EC2 instance |
| launch_template_metadata_options | Metadata options of the launch template created for the EC2 instance |
| launch_template_monitoring | Monitoring configuration of the launch template created for the EC2 instance |
| launch_template_tag_specifications | Tag specifications of the launch template created for the EC2 instance |
| launch_template_tags | Tags of the launch template created for the EC2 instance |
| autoscaling_group_id | ID of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_name | Name of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_arn | ARN of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_desired_capacity | Desired capacity of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_max_size | Maximum size of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_min_size | Minimum size of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_health_check_grace_period | Health check grace period of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_health_check_type | Health check type of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_vpc_zone_identifier | VPC zone identifier of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_launch_template | Launch template configuration of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_tags | Tags of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_target_group_arns | Target group ARNs of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_load_balancers | Load balancers of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_placement_group | Placement group of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_service_linked_role_arn | Service linked role ARN of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_max_instance_lifetime | Maximum instance lifetime of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_capacity_rebalance | Capacity rebalance configuration of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_warm_pool | Warm pool configuration of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_mixed_instances_policy | Mixed instances policy of the Auto Scaling Group created for the EC2 instance |
| autoscaling_group_instance_refresh | Instance refresh configuration of the Auto Scaling Group created for the EC2 instance |
| autoscaling_policy_ids | IDs of the Auto Scaling policies created for the EC2 instance |
| autoscaling_policy_names | Names of the Auto Scaling policies created for the EC2 instance |
| autoscaling_policy_arns | ARNs of the Auto Scaling policies created for the EC2 instance |
| autoscaling_policy_adjustment_types | Adjustment types of the Auto Scaling policies created for the EC2 instance |
| autoscaling_policy_scaling_adjustments | Scaling adjustments of the Auto Scaling policies created for the EC2 instance |
| autoscaling_policy_cooldowns | Cooldowns of the Auto Scaling policies created for the EC2 instance |
| autoscaling_policy_metric_aggregation_types | Metric aggregation types of the Auto Scaling policies created for the EC2 instance |
| autoscaling_policy_min_adjustment_magnitudes | Minimum adjustment magnitudes of the Auto Scaling policies created for the EC2 instance |
| autoscaling_policy_step_adjustments | Step adjustments of the Auto Scaling policies created for the EC2 instance |
| autoscaling_policy_target_tracking_configurations | Target tracking configurations of the Auto Scaling policies created for the EC2 instance |
| cloudwatch_alarm_ids | IDs of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_names | Names of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_arns | ARNs of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_comparison_operators | Comparison operators of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_evaluation_periods | Evaluation periods of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_metric_names | Metric names of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_namespaces | Namespaces of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_periods | Periods of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_statistics | Statistics of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_thresholds | Thresholds of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_descriptions | Descriptions of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_actions | Alarm actions of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_ok_actions | OK actions of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_insufficient_data_actions | Insufficient data actions of the CloudWatch alarms created for the EC2 instance |
| cloudwatch_alarm_dimensions | Dimensions of the CloudWatch alarms created for the EC2 instance |
| ami_id | AMI ID used for the EC2 instance |
| amazon_linux_2_ami_id | Amazon Linux 2 AMI ID |
| ubuntu_ami_id | Ubuntu AMI ID |
| custom_ami_id | Custom AMI ID |
| local_ami_id | Local AMI ID value |

## Examples

See the `examples/` directory for complete usage examples:

- `examples/main.tf` - Various EC2 instance configurations
- `examples/outputs.tf` - Example outputs

## Testing

See the `test/` directory for test configurations:

- `test/main.tf` - Test EC2 instance configurations
- `test/outputs.tf` - Test outputs

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This module is licensed under the MIT License. See LICENSE file for details.

## Changelog

### Version 1.0.0
- Initial release
- Support for basic EC2 instances
- Launch template support
- Auto Scaling Group support
- IAM role integration
- Security group management
- Key pair management
- Comprehensive outputs