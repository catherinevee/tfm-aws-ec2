# Example usage of the custom EC2 module

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Example 1: Basic EC2 Instance
module "basic_ec2" {
  source = "../"
  
  instance_name = "basic-instance"
  instance_type = "t3.micro"
  subnet_id     = "subnet-12345678" # Replace with your subnet ID
  
  use_latest_ami = true
  ami_type       = "amazon_linux_2"
  
  create_security_group = true
  vpc_id                = "vpc-12345678" # Replace with your VPC ID
  
  security_group_ingress_rules = [
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
    },
    {
      description     = "HTTP access"
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      self            = false
      ipv6_cidr_blocks = []
      prefix_list_ids = []
    }
  ]
  
  associate_public_ip_address = true
  
  root_block_device = [
    {
      delete_on_termination = true
      encrypted             = true
      volume_size           = 20
      volume_type           = "gp3"
    }
  ]
  
  tags = {
    Environment = "example"
    Project     = "terraform-ec2-module"
    Owner       = "devops"
  }
}

# Example 2: EC2 Instance with Key Pair
module "ec2_with_key" {
  source = "../"
  
  instance_name = "key-instance"
  instance_type = "t3.small"
  subnet_id     = "subnet-12345678" # Replace with your subnet ID
  
  create_key_pair = true
  public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAQC..." # Replace with your public key
  
  create_security_group = false
  security_group_ids    = ["sg-12345678"] # Replace with your security group ID
  
  use_latest_ami = true
  ami_type       = "ubuntu"
  
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
  
  tags = {
    Environment = "example"
    Project     = "terraform-ec2-module"
    Owner       = "devops"
  }
}

# Example 3: EC2 Instance with IAM Role
module "ec2_with_iam" {
  source = "../"
  
  instance_name = "iam-instance"
  instance_type = "t3.medium"
  subnet_id     = "subnet-12345678" # Replace with your subnet ID
  
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
    },
    {
      Effect = "Allow"
      Action = [
        "ec2:DescribeInstances",
        "ec2:DescribeTags"
      ]
      Resource = "*"
    }
  ]
  
  custom_ami_id    = "ami-12345678" # Replace with your custom AMI ID
  custom_ami_owner = "self"
  
  create_security_group = true
  vpc_id                = "vpc-12345678" # Replace with your VPC ID
  
  security_group_ingress_rules = [
    {
      description     = "SSH access"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["10.0.0.0/8"]
      security_groups = []
      self            = false
      ipv6_cidr_blocks = []
      prefix_list_ids = []
    }
  ]
  
  tags = {
    Environment = "example"
    Project     = "terraform-ec2-module"
    Owner       = "devops"
  }
}

# Example 4: EC2 Instance with Launch Template and Auto Scaling Group
module "ec2_asg" {
  source = "../"
  
  instance_name = "asg-instance"
  instance_type = "t3.micro"
  subnet_id     = "subnet-12345678" # Replace with your subnet ID
  
  use_launch_template = true
  create_autoscaling_group = true
  
  asg_desired_capacity = 2
  asg_max_size         = 5
  asg_min_size         = 1
  asg_subnet_ids       = ["subnet-12345678", "subnet-87654321"] # Replace with your subnet IDs
  
  asg_tags = [
    {
      key                 = "Name"
      value               = "asg-instance"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = "example"
      propagate_at_launch = true
    }
  ]
  
  asg_policies = {
    scale_up = {
      name = "scale-up"
      adjustment_type = "ChangeInCapacity"
      scaling_adjustment = 1
      cooldown = 300
      metric_aggregation_type = "Average"
    },
    scale_down = {
      name = "scale-down"
      adjustment_type = "ChangeInCapacity"
      scaling_adjustment = -1
      cooldown = 300
      metric_aggregation_type = "Average"
    }
  }
  
  cloudwatch_alarms = {
    high_cpu = {
      alarm_name = "high-cpu-utilization"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods = 2
      metric_name = "CPUUtilization"
      namespace = "AWS/EC2"
      period = 120
      statistic = "Average"
      threshold = 80
      alarm_description = "Scale up if CPU > 80% for 4 minutes"
      dimensions = [
        {
          name  = "AutoScalingGroupName"
          value = "asg-instance"
        }
      ]
    },
    low_cpu = {
      alarm_name = "low-cpu-utilization"
      comparison_operator = "LessThanThreshold"
      evaluation_periods = 2
      metric_name = "CPUUtilization"
      namespace = "AWS/EC2"
      period = 120
      statistic = "Average"
      threshold = 20
      alarm_description = "Scale down if CPU < 20% for 4 minutes"
      dimensions = [
        {
          name  = "AutoScalingGroupName"
          value = "asg-instance"
        }
      ]
    }
  }
  
  create_security_group = true
  vpc_id                = "vpc-12345678" # Replace with your VPC ID
  
  security_group_ingress_rules = [
    {
      description     = "SSH access"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["10.0.0.0/8"]
      security_groups = []
      self            = false
      ipv6_cidr_blocks = []
      prefix_list_ids = []
    },
    {
      description     = "HTTP access"
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      self            = false
      ipv6_cidr_blocks = []
      prefix_list_ids = []
    }
  ]
  
  block_device_mappings = [
    {
      device_name = "/dev/xvda"
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 30
        volume_type           = "gp3"
        throughput            = 125
      }
    }
  ]
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Auto Scaling Group!</h1>" > /var/www/html/index.html
              EOF
  
  tags = {
    Environment = "example"
    Project     = "terraform-ec2-module"
    Owner       = "devops"
  }
}

# Example 5: Multiple EC2 Instances
module "multiple_ec2" {
  source = "../"
  
  instance_name = "multi-instance"
  instance_count = 3
  instance_type = "t3.micro"
  subnet_id     = "subnet-12345678" # Replace with your subnet ID
  
  use_latest_ami = true
  ami_type       = "amazon_linux_2"
  
  create_security_group = true
  vpc_id                = "vpc-12345678" # Replace with your VPC ID
  
  security_group_ingress_rules = [
    {
      description     = "SSH access"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["10.0.0.0/8"]
      security_groups = []
      self            = false
      ipv6_cidr_blocks = []
      prefix_list_ids = []
    }
  ]
  
  root_block_device = [
    {
      delete_on_termination = true
      encrypted             = true
      volume_size           = 25
      volume_type           = "gp3"
    }
  ]
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from instance $(curl -s http://169.254.169.254/latest/meta-data/instance-id)!</h1>" > /var/www/html/index.html
              EOF
  
  tags = {
    Environment = "example"
    Project     = "terraform-ec2-module"
    Owner       = "devops"
  }
}

# Example 6: Advanced EC2 Instance with Placement Group and Enhanced Features
module "advanced_ec2" {
  source = "../"
  
  instance_name = "advanced-instance"
  instance_type = "t3.large"
  subnet_id     = "subnet-12345678" # Replace with your subnet ID
  
  # Placement Group
  create_placement_group = true
  placement_group_strategy = "cluster"
  placement_group_tags = {
    Purpose = "high-performance-computing"
  }
  
  # Enhanced Security Group
  create_security_group = true
  vpc_id                = "vpc-12345678" # Replace with your VPC ID
  security_group_name   = "advanced-instance-sg"
  security_group_description = "Security group for advanced EC2 instance with enhanced features"
  
  security_group_ingress_rules = [
    {
      description     = "SSH access"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["10.0.0.0/8"]
      security_groups = []
      self            = false
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
    },
    {
      description     = "HTTPS access"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      self            = false
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
    }
  ]
  
  security_group_tags = {
    SecurityLevel = "high"
    Compliance    = "pci-dss"
  }
  
  # Enhanced IAM Role
  create_iam_role = true
  iam_role_name   = "advanced-instance-role"
  iam_role_description = "IAM role for advanced EC2 instance with comprehensive permissions"
  iam_role_path   = "/custom-roles/"
  iam_role_max_session_duration = 7200
  iam_role_permissions_boundary = "arn:aws:iam::123456789012:policy/PermissionsBoundary"
  
  iam_policy_statements = [
    {
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ]
      Resource = [
        "arn:aws:s3:::my-advanced-bucket",
        "arn:aws:s3:::my-advanced-bucket/*"
      ]
      Condition = {
        StringEquals = {
          "aws:RequestTag/Environment" = "production"
        }
      }
    },
    {
      Effect = "Allow"
      Action = [
        "ec2:DescribeInstances",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DescribeSecurityGroups"
      ]
      Resource = "*"
    },
    {
      Effect = "Allow"
      Action = [
        "cloudwatch:PutMetricData",
        "cloudwatch:GetMetricStatistics"
      ]
      Resource = "*"
    }
  ]
  
  iam_role_tags = {
    RoleType = "ec2-service-role"
    ManagedBy = "terraform"
  }
  
  # Enhanced Launch Template
  use_launch_template = true
  launch_template_name = "advanced-instance-lt"
  launch_template_description = "Launch template for advanced EC2 instance with comprehensive configuration"
  launch_template_disable_api_stop = true
  launch_template_disable_api_termination = false
  launch_template_instance_initiated_shutdown_behavior = "stop"
  
  launch_template_instance_requirements = {
    accelerator_count = {
      min = 0
      max = 1
    }
    accelerator_manufacturers = ["nvidia"]
    accelerator_names = ["V100"]
    accelerator_total_memory_mib = {
      min = 16384
      max = 32768
    }
    accelerator_types = ["gpu"]
    allowed_instance_types = ["g4dn.xlarge", "g4dn.2xlarge", "g5.xlarge"]
    bare_metal = "excluded"
    baseline_ebs_bandwidth_mbps = {
      min = 1000
      max = 10000
    }
    burstable_performance = "excluded"
    cpu_manufacturers = ["intel", "amd"]
    excluded_instance_types = ["t2.*", "t3.*"]
    instance_generations = ["current"]
    local_storage = "included"
    local_storage_types = ["ssd"]
    max_spot_price_as_percentage_of_optimal_on_demand_price = 80
    memory_gib_per_vcpu = {
      min = 2
      max = 8
    }
    memory_mib = {
      min = 8192
      max = 65536
    }
    network_bandwidth_gbps = {
      min = 1
      max = 25
    }
    network_interface_count = {
      min = 1
      max = 4
    }
    on_demand_max_price_percentage_over_lowest_price = 200
    require_hibernate_support = false
    spot_max_price_percentage_over_lowest_price = 100
    total_local_storage_gb = {
      min = 100
      max = 2000
    }
    vcpu_count = {
      min = 2
      max = 16
    }
  }
  
  launch_template_maintenance_options = {
    auto_recovery = "default"
  }
  
  launch_template_private_dns_name_options = {
    enable_resource_name_dns_aaaa_record = true
    enable_resource_name_dns_a_record    = true
    hostname_type                        = "ip-name"
  }
  
  # Enhanced Block Device Mappings
  block_device_mappings = [
    {
      device_name = "/dev/xvda"
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 50
        volume_type           = "gp3"
        throughput            = 250
        iops                  = 3000
      }
    },
    {
      device_name = "/dev/sdf"
      ebs = {
        delete_on_termination = false
        encrypted             = true
        volume_size           = 100
        volume_type           = "io2"
        iops                  = 5000
      }
    }
  ]
  
  # Enhanced Network Interfaces
  network_interfaces = [
    {
      device_index                = 0
      associate_public_ip_address = false
      delete_on_termination       = true
      description                 = "Primary network interface"
      subnet_id                   = "subnet-12345678"
      ipv4_prefix_count           = 2
      ipv6_address_count          = 1
      network_card_index          = 0
    }
  ]
  
  # Enhanced Metadata Options
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "enabled"
  }
  
  # Enhanced User Data
  user_data = <<-EOF
              #!/bin/bash
              # Advanced instance setup script
              
              # Update system
              yum update -y
              
              # Install additional packages
              yum install -y \
                httpd \
                php \
                php-mysql \
                mariadb \
                git \
                docker \
                jq \
                aws-cli
              
              # Start and enable services
              systemctl start httpd
              systemctl enable httpd
              systemctl start docker
              systemctl enable docker
              
              # Configure security
              sed -i 's/^#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
              systemctl restart sshd
              
              # Create application directory
              mkdir -p /var/www/html/app
              
              # Create a simple web application
              cat > /var/www/html/index.html << 'HTML'
              <!DOCTYPE html>
              <html>
              <head>
                  <title>Advanced EC2 Instance</title>
              </head>
              <body>
                  <h1>Advanced EC2 Instance Running</h1>
                  <p>Instance ID: <span id="instance-id"></span></p>
                  <p>Availability Zone: <span id="az"></span></p>
                  <p>Instance Type: <span id="type"></span></p>
                  <script>
                      fetch('http://169.254.169.254/latest/meta-data/instance-id')
                          .then(response => response.text())
                          .then(data => document.getElementById('instance-id').textContent = data);
                      fetch('http://169.254.169.254/latest/meta-data/placement/availability-zone')
                          .then(response => response.text())
                          .then(data => document.getElementById('az').textContent = data);
                      fetch('http://169.254.169.254/latest/meta-data/instance-type')
                          .then(response => response.text())
                          .then(data => document.getElementById('type').textContent = data);
                  </script>
              </body>
              </html>
              HTML
              
              # Set proper permissions
              chown -R apache:apache /var/www/html
              chmod -R 755 /var/www/html
              
              # Create a health check endpoint
              cat > /var/www/html/health << 'HEALTH'
              OK
              HEALTH
              
              echo "Advanced instance setup completed successfully!"
              EOF
  
  # Enhanced Root Block Device
  root_block_device = [
    {
      delete_on_termination = true
      encrypted             = true
      volume_size           = 50
      volume_type           = "gp3"
      throughput            = 250
      iops                  = 3000
    }
  ]
  
  # Enhanced EBS Block Devices
  ebs_block_device = [
    {
      device_name           = "/dev/sdf"
      delete_on_termination = false
      encrypted             = true
      volume_size           = 100
      volume_type           = "io2"
      iops                  = 5000
    },
    {
      device_name           = "/dev/sdg"
      delete_on_termination = false
      encrypted             = true
      volume_size           = 200
      volume_type           = "st1"
    }
  ]
  
  # Enhanced Instance Configuration
  associate_public_ip_address = false
  disable_api_stop           = true
  disable_api_termination    = false
  instance_initiated_shutdown_behavior = "stop"
  enable_detailed_monitoring = true
  source_dest_check          = true
  tenancy                    = "default"
  hibernation                = false
  
  # Enhanced CPU Configuration
  cpu_core_count       = 4
  cpu_threads_per_core = 2
  
  # Enhanced Tags
  tags = {
    Environment = "production"
    Project     = "advanced-ec2-module"
    Owner       = "devops-team"
    CostCenter  = "engineering"
    Backup      = "true"
    Monitoring  = "enabled"
    Compliance  = "pci-dss"
    DataClassification = "confidential"
  }
} 