
module "Bastion_service_sg" {
  source = "./modules/terraform-aws-security-group"

  name        = "Bastion_service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "43.249.224.222/32"
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

module "Private_Instance_sg" {
  source = "./modules/terraform-aws-security-group"

  name        = "Private_Instance_sg"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "10.0.0.0/16"
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

module "Public_Instance_sg" {
  source = "./modules/terraform-aws-security-group"

  name        = "Public_Instance_sg"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "43.249.224.222/32"
      # cidr_blocks =  module.myip.address
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

resource aws_security_group allow_ssh {
  name        = "allow_ssh"
  description = "Allow SSH inbound connections"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # cidr_blocks = concat(module.myip.address ,"/32"
    # cidr_blocks = "${module.myip.address}/32"
    # cidr_blocks = join("",[module.myip.address],["/32"])
    cidr_blocks= var.myIp

  }
}