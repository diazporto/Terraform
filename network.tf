resource "aws_vpc" "practico-vpc" {
  cidr_block           = var.CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC_ej_Terraform"

  }
}

resource "aws_subnet" "practico-private-subnet" {
  vpc_id                  = aws_vpc.practico-vpc.id
  cidr_block              = var.subnet
  map_public_ip_on_launch = "true"
  tags = {
    Name = "practico-subnet-terraform"
  }
}

resource "aws_internet_gateway" "practico-gateway" {
  vpc_id = aws_vpc.practico-vpc.id
  tags = {
    Name = "practico-gateway"
  }
}

resource "aws_default_route_table" "practico-route" {
  default_route_table_id = aws_vpc.practico-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.practico-gateway.id
  }
  tags = {
    Name = "practico-default-route"
  }
}