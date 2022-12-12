data "aws_availability_zones" "available"{
  state = "available"
}

// vpc resource block

resource "aws_vpc" "dev_vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = merge({
    Envirenment = var.environment 
    Build_By = var.buildby
      })
}
############
# PUB-SUBNET
############

resource "aws_subnet" "pub-snet" {
  vpc_id     = aws_vpc.dev_vpc.id
  for_each          = var.pub-snet
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["availability_zone"]
  map_public_ip_on_launch = true

    tags = merge({
    Envirenment = var.environment 
    BuildBy = var.buildby
      })
}

############
# PVT-SUBNET
############
resource "aws_subnet" "pri-snet" {
  vpc_id                = aws_vpc.dev_vpc.id
  for_each              = var.pri-snet
  cidr_block            = each.value["cidr_block"]
  availability_zone     = each.value["availability_zone"]

     tags = merge({
    Envirenment = var.environment 
    BuildBy = var.buildby
      })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_vpc.id
}

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

    tags = merge({
    Envirenment = var.environment 
    BuildBy = var.buildby
      })
}

resource "aws_route_table_association" "rt-association" {
  for_each = aws_subnet.pub-snet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_nat_gateway" "nat-gt" {
  
  count = var.is_nat_required ? 1 : 0
  subnet_id = lookup(aws_subnet.pub-snet,var.nat-pub-id,null).id
     tags = merge({
    Envirenment = var.environment 
    BuildBy = var.buildby
      })
    depends_on = [aws_internet_gateway.igw]
  }
