
data "aws_availability_zones" "azs" {
  state = "available" #it will look at the avail azs#
}

locals {
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
  azs        = data.aws_availability_zones.azs.names
  vpc_id     = try(aws_vpc.kojitechs_vpc[0].id, "")
  create_vpc = var.create_vpc
}


#creating VPC
resource "aws_vpc" "kojitechs_vpc" {
  count = local.create_vpc ? length(var.vpc_cidr) : 0

  cidr_block           = var.vpc_cidr[count.index]
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "kojitechs_vpc"
  }
}

#creating IGW # 
resource "aws_internet_gateway" "igw" {
  count = local.create_vpc ? length(var.vpc_cidr) : 0

  vpc_id = local.vpc_id
  tags = {
    Name = "kojitechs_igw"
  }
}

#creating public subnets using counts
resource "aws_subnet" "pub_subnet" {
  count = local.create_vpc ? length(var.pub_subnet_cidr) : 0

  vpc_id                  = local.vpc_id
  cidr_block              = var.pub_subnet_cidr[count.index]
  availability_zone       = element(local.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_subnet_${count.index + 1}"
  }
}

resource "aws_subnet" "priv_subnet" {
  count             = local.create_vpc ? length(var.priv_subnet_cidr) : 0
  vpc_id            = local.vpc_id
  cidr_block        = var.priv_subnet_cidr[count.index]
  availability_zone = element(local.azs, count.index)

  tags = {
    Name = "priv_subnet_${element(local.azs, count.index)}" 
  }
}

resource "aws_subnet" "database_subnet" {
  count = local.create_vpc ? length(var.database_subnet_cidr) : 0

  vpc_id            = local.vpc_id
  cidr_block        = var.database_subnet_cidr[count.index]
  availability_zone = element(local.azs, count.index)

  tags = {
    Name = "database_subnet_${element(local.azs, count.index)}" 
  }
}

#creating public route table
resource "aws_route_table" "route_table" {
  count = local.create_vpc ? 1 : 0

  vpc_id = local.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id

  }

  tags = {
    Name = "public_route_table"
  }
}

#creating route table association for the public subnets
resource "aws_route_table_association" "pub_subnet" {
  count = local.create_vpc ? length(var.pub_subnet_cidr) : 0

  subnet_id      = aws_subnet.pub_subnet[count.index].id
  route_table_id = aws_route_table.route_table[0].id
}

# working with default route table
resource "aws_default_route_table" "default_routetable" {
  count = local.create_vpc ? length(var.vpc_cidr) : 0

  default_route_table_id = try(aws_vpc.kojitechs_vpc[0].default_route_table_id, "")

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example[0].id # NAT GATEWAY.  PPRIVATE()
  }
}

# creating NAT gateway
resource "aws_nat_gateway" "example" {
  count = local.create_vpc ? 1 : 0

  allocation_id = aws_eip.eip[0].id
  subnet_id     = aws_subnet.priv_subnet[0].id

  tags = {
    Name = "Gw_Nat"
  }
  depends_on = [aws_internet_gateway.igw]
}

#creating EIP
resource "aws_eip" "eip" {
  count      = local.create_vpc ? 1 : 0
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}

/*
locals {
  pub_subnet = {
    pub_subnet_1 = {
      cidr = "10.0.4.0/24"
      az   = local.azs[0]
    }
    pub_subnet_2 = {
      cidr = "10.0.6.0/24"
      az   = local.azs[1]
    }
  }
  pub_subnet_3 = {
    cidr = "10.0.8.0/24"
    az   = local.azs[2]
  }
  pub_subnet_4 = {
    cidr = "10.0.10.0/24"
    az   = local.azs[3]
  }
}

resource "aws_subnet" "pub_subnet_foreach" {
  for_each = local.create_vpc ? local.pub_subnet : {}

  vpc_id                  = local.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}
*/