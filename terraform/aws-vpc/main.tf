provider "aws" {
  region                   = "ap-south-1"
  shared_credentials_files = ["/home/amit/.aws/credentials"]
}


# Create AWS VPC
# CIDR - 10.0.0.0/16
resource "aws_vpc" "test-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "test-vpc"
  }
}