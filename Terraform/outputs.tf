## Terraform Output Values

## VPC Output values

# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# VPC CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# VPC Private Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# VPC NAT gateway Public IP
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# VPC AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.vpc.azs
}

## AWS EC2 Security Group Terraform Outputs

# Public Bastion Host Security Group Outputs
# bastion_sg_group_id
output "Bastion_service_sg_group_id" {
  description = "The ID of the Bastion service security group"
  value       = module.Bastion_service_sg.security_group_id
}

# bastion_sg_group_name
output "Bastion_service_sg_group_name" {
  description = "The name of the security group"
  value       = module.Bastion_service_sg.security_group_name
  
}

# private_sg_group_id
output "Private_Instance_sg_group_id" {
  description = "The ID of the private security group"
  value       = module.Private_Instance_sg.security_group_id
}

# private_sg_group_name
output "Private_Instance_sg_group_name" {
  description = "The name of the security group"
  value       = module.Private_Instance_sg.security_group_name
}

# Public_sg_group_id
output "Public_Instance_sg_group_id" {
  description = "The ID of the Private security group"
  value       = module.Public_Instance_sg.security_group_id
}

# Public_sg_group_name
output "Public_sg_group_name" {
  description = "The name of the security group"
  value       = module.Public_Instance_sg.security_group_name
}



## AWS EC2 Instances details from Terraform 

# Public EC2 Instances - Bastion Host
# ec2_instance_Bastion_id
output "ec2_instance_Bastion_id" {
  description = "List of IDs of instances"
  value       = module.ec2_instance_Bastion.id
}

# ec2_instance_Bastion_public_ip
output "ec2_instance_Bastion_public_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2_instance_Bastion.public_ip
}

# Private EC2 Instances
# ec2_instance_private_Jenkins_ids
output "ec2_instance_Jenkins_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_instance_Jenkins.id
}
# # ec2_instance_private_Jenkins_Ip
# output "ec2_instance_private_Jenkins_Ip" {
#   description = "List of private IP addresses assigned to the instances"
#   value       = module.ec2_instance_Jenkins.private_ip
# }

# ec2_instance_private_App_ids
output "ec2_instance_private_App_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_instance_app.id
}

# # ec2_instance_private_App_Ip
# output "ec2_instance_private_App_Ip" {
#   description = "List of private IP addresses assigned to the instances"
#   value       = module.ec2_instance_app.private_ip
# }


