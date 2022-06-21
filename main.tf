
# Root module
locals {
  vpc_id     = try(aws_vpc.kojitechs_vpc[0].id, "")
  create_vpc = var.create_vpc
}

#creating VPC
resource "aws_vpc" "kojitechs_vpc" {
  count = local.create_vpc ? length(var.vpc_cidr) : 0

  cidr_block           = var.vpc_cidr[count.index]
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "kojitechs_vpc"
  }
}

#creating IGW # 
resource "aws_internet_gateway" "igw" {
  count  = local.create_vpc ? length(var.vpc_cidr) : 0
  vpc_id = local.vpc_id
}

#creating public subnets using counts
resource "aws_subnet" "pub_subnet" {
  count = local.create_vpc ? length(var.pub_subnet_cidr) : 0

  vpc_id                  = local.vpc_id
  cidr_block              = var.pub_subnet_cidr[count.index]
  availability_zone       = element(var.pub_subnet_az, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_subnet_${count.index + 1}"
  }
}

resource "aws_subnet" "priv_subnet" {
  count             = local.create_vpc ? length(var.priv_subnet_cidr) : 0
  vpc_id            = local.vpc_id
  cidr_block        = var.priv_subnet_cidr[count.index]
  availability_zone = element(var.priv_subnet_az, count.index)

  tags = {
    Name = "priv_subnet_${element(var.pub_subnet_az, count.index)}" #appending the az name to the subn
  }
}

resource "aws_subnet" "database_subnet" {
  count = local.create_vpc ? length(var.database_subnet_cidr) : 0

  vpc_id            = local.vpc_id
  cidr_block        = var.database_subnet_cidr[count.index]
  availability_zone = element(var.database_subnet_az, count.index)

  tags = {
    Name = "database_subnet_${element(var.database_subnet_az, count.index)}" #appending the az name to the subn
  }
}

#creating public route table
resource "aws_route_table" "route_table" {
  count = local.create_vpc ? 1 : 0

  vpc_id = local.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[count.index].id

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

  default_route_table_id = aws_vpc.kojitechs_vpc[count.index].default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example[0].id # NAT GATEWAY.  PPRIVATE()
  }
}

# creating NAT gateway
resource "aws_nat_gateway" "example" {
  count = local.create_vpc ? 1 : 0

  allocation_id = aws_eip.eip[0].id
  subnet_id     = aws_subnet.pub_subnet[0].id
  depends_on    = [aws_internet_gateway.igw]
}

#creating EIP
resource "aws_eip" "eip" {
  count      = local.create_vpc ? 1 : 0
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}
