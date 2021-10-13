terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.61.0"
    }
  }
}

terraform {
  backend "s3"{
    bucket = "upgrad-assignment-m4"
    key    = "demo1/tfstatefile"
    region = "us-east-1"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}