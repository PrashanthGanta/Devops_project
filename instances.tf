module "ec2_instance_Bastion" {
  source  = "./modules/terraform-aws-ec2-instance"
  # version = "~> 3.0"

  name = "Bastion"

  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  key_name               = "RHEL"
  monitoring             = true
  vpc_security_group_ids = [module.Bastion_service_sg.security_group_id, module.Public_Instance_sg.security_group_id]
  # subnet_id              = "subnet-eddcdzz4"
  # subnet_id              = aws_subnet.public.[0].ID
  subnet_id               = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ec2_instance_Jenkins" {
  source  = "./modules/terraform-aws-ec2-instance"
  # version = "~> 3.0"

  name = "Jenkins"

  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  key_name               = "RHEL"
  monitoring             = true
  vpc_security_group_ids = [module.Private_Instance_sg.security_group_id]
  # subnet_id              = "subnet-eddcdzz4"
  # subnet_id              = aws_subnet.public.[0].ID
  subnet_id               = module.vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ec2_instance_app" {
  source  = "./modules/terraform-aws-ec2-instance"
  # version = "~> 3.0"

  name = "app"

  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  key_name               = "RHEL"
  monitoring             = true
  vpc_security_group_ids = [module.Public_Instance_sg.security_group_id]
  # subnet_id              = "subnet-eddcdzz4"
  # subnet_id              = aws_subnet.public.[0].ID
  subnet_id               = module.vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}