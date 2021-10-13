## VPC Creation 
# Created VPC with desired configurations
# VPC, priavate and public subnets, CIDR, availabilty zones, IGW and Nat gatway
module "vpc" {
  source = "./modules/terraform-aws-vpc"

  name = "my-vpc-project-m4"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway  = true # single nat_gateway allow the vpc with single nat server in public subnet to access the private subnet instances

  create_igw = true # Creates IGW (internet gatway) within the VPC

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
## To get the ip address of the terraform invoking system., self ip
module myip {
  source  = "4ops/myip/http"
  version = "1.0.0"
}

