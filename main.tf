
data "aws_availability_zones" "azs" {
  state = "available" #it will look at the avail azs#
}

locals {
  vpc_id = aws_vpc.kojitechs_vpc.id
  mandatory_tag = {
    line_of_business        = "hospital"
    ado                     = "max"
    tier                    = "WEB"
    operational_environment = upper(terraform.workspace)
    tech_poc_primary        = "udu.udu25@gmail.com"
    tech_poc_secondary      = "udu.udu25@gmail.com"
    application             = "http"
    builder                 = "udu.udu25@gmail.com"
    application_owner       = "kojitechs.com"
    vpc                     = "WEB"
    cell_name               = "WEB"
    component_name          = "kojitechs"
  }
}

#creating VPC
resource "aws_vpc" "kojitechs_vpc" {

  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true #to enable nat gateway
  enable_dns_support   = true #to enable nat gateway

  tags = {
    "Name" = "kojitech_vpc"
  }
}

#using count to create public subnets

resource "aws_subnet" "pub_subnet" {
  count                   = length(var.pub_subnet_cidr)
  vpc_id                  = local.vpc_id
  cidr_block              = var.pub_subnet_cidr[count.index]
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet ${1 + count.index}"
  }
}

#using count to create private subnets

resource "aws_subnet" "priv_subnet" {
  count             = length(var.priv_subnet_cidr)
  vpc_id            = local.vpc_id
  cidr_block        = var.priv_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "priv_subnet_${data.aws_availability_zones.azs.names[count.index]}"
  }
}


#using count to create database subnets

resource "aws_subnet" "database_subnet" {
  count             = length(var.database_subnet_cidr)
  vpc_id            = local.vpc_id
  cidr_block        = var.database_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "database_subnet_${data.aws_availability_zones.azs.names[count.index]}"
  }
}


#creating public subnet individually

/*resource "aws_subnet" "pub_subnet_1" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.pub_subnet_cidr[0]
  availability_zone       = data.aws_availability_zones.azs.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_subnet_1"
  }
}

resource "aws_subnet" "pub_subnet_2" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.pub_subnet_cidr[1]
  availability_zone       = data.aws_availability_zones.azs.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_subnet_2"
  }
}

resource "aws_subnet" "priv_subnet_1" {
  vpc_id            = local.vpc_id
  cidr_block        = var.priv_subnet_cidr[0]
  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name = "priv_subnet_${data.aws_availability_zones.azs.names[0]}" #appending the az name to the subn
  }
}

resource "aws_subnet" "priv_subnet_2" {
  vpc_id            = local.vpc_id
  cidr_block        = var.priv_subnet_cidr[1]
  availability_zone = data.aws_availability_zones.azs.names[1]

  tags = {
    Name = "priv_subnet_${data.aws_availability_zones.azs.names[1]}" #appending the az name to the subn
  }
}

resource "aws_subnet" "database_subnet_1" {
  vpc_id            = local.vpc_id
  cidr_block        = var.database_subnet_cidr[0]
  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name = "database_subnet_${data.aws_availability_zones.azs.names[0]}" #appending the az name to the subn
  }
}

resource "aws_subnet" "database_subnet_2" {
  vpc_id            = local.vpc_id
  cidr_block        = var.database_subnet_cidr[1]
  availability_zone = data.aws_availability_zones.azs.names[1]

  tags = {
    Name = "database_subnet_${data.aws_availability_zones.azs.names[1]}"
  }
}*/


#creating public IGW

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "igw"
  }
}

#creating public route table

resource "aws_route_table" "public" {
  vpc_id = local.vpc_id

  route {
    cidr_block = var.iga_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_subnet_RT"
  }
}

#associating public route table to public subnets
resource "aws_route_table_association" "public" {
  count = length(var.pub_subnet_cidr)

  subnet_id      = aws_subnet.pub_subnet[count.index].id
  route_table_id = aws_route_table.public.id
}

