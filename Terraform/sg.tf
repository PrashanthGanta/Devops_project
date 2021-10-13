## Security groups

# bastion server security group with having only self ip inbound/ingress rules access with ssh port 22
# outbound/Egress rules to everyone
module "Bastion_service_sg" {
  source = "./modules/terraform-aws-security-group"

  name        = "Bastion_service"
  description = "Security group for bastion-service with custom ports open within self ip open"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      # cidr_blocks = "0.0.0.0/0" # To provide access to everyone uncomment this line
      cidr_blocks =  "${chomp(data.http.myip.body)}/32"
      description = "Ingress Rule"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Egress Rule"
    },
  ]

}

# Private server security group with having VPC ip adress as inbound/ingress with all traffic access
# outbound/Egress rules to everyone
module "Private_Instance_sg" {
  source = "./modules/terraform-aws-security-group"

  name        = "Private_Instance_sg"
  description = "Security group for private instance jenkins-service with custom ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "10.0.0.0/16" ## All ip address inside VPC-CIDR access
      description = "Ingress Rule"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Egress Rule"
    },
  ]

}

# public server security group with having self ip adress as inbound/ingress with 80 port access
# used for ALB security group here in this project
# outbound/Egress rules to everyone
module "Public_Instance_sg" {
  source = "./modules/terraform-aws-security-group"

  name        = "Public_Instance_sg"
  description = "Security group for alb and public instance with custom ports open with selfip"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      # cidr_blocks = "0.0.0.0/0" # To provide access to everyone uncomment this line
      cidr_blocks =  "${chomp(data.http.myip.body)}/32"
      description = "Ingress Rule"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Egress Rule"
    },
  ]

}

