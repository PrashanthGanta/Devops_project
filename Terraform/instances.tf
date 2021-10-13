## Bastion server to communicate the private instances created in private subnet
# Configured with public subnet to access VPC instances outside the VPC network
module "ec2_instance_Bastion" {
  source  = "./modules/terraform-aws-ec2-instance"
  # version = "~> 3.0"

  name = "Bastion"

  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  key_name               = "RHEL" ## keyname created for the project to access the instaces
  monitoring             = true
  vpc_security_group_ids = [module.Bastion_service_sg.security_group_id, module.Public_Instance_sg.security_group_id]
  subnet_id               = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

## Jenkins server will get hosted on private subnet
# jenkisn server is insatelled in this insatance to build and deploy the node app
# This app can accesed with ALB configuration "www.ALb.domain.com/jenkins"
module "ec2_instance_Jenkins" {
  depends_on = [module.vpc]
  source  = "./modules/terraform-aws-ec2-instance"
  # version = "~> 3.0"

  name = "Jenkins"

  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  key_name               = "RHEL" ## keyname created for the project to access the instaces
  monitoring             = true
  vpc_security_group_ids = [module.Private_Instance_sg.security_group_id]
  subnet_id               = module.vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

## App server to run the node docker image to run on this instance
# Created in private subnet
# This app can accesed with ALB configuration "www.ALb.domain.com/app"
module "ec2_instance_app" {
  depends_on = [module.vpc]
  source  = "./modules/terraform-aws-ec2-instance"
  # version = "~> 3.0"

  name = "app"

  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  key_name               = "RHEL" ## keyname created for the project to access the instaces
  monitoring             = true
  vpc_security_group_ids = [module.Public_Instance_sg.security_group_id]
  subnet_id               = module.vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}