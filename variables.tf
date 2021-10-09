variable "myIp" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
#   default     = "0.0.0.0/0"
#   default = concat(module.myip.address ,["/32"])[0]
  default = module.myip.address

#   concat(aws_db_subnet_group.database.*.name, [""])[0]

}