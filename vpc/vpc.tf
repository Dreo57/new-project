resource "aws_vpc" "projvpc" {
  cidr_block = data.aws_ssm_parameter.vpc_cidr.value
  enable_dns_support= true
  enable_dns_hostnames= true
  tags = {
    Name= "Prod-VPC"
  }
}

data "aws_ssm_parameter" "vpc_cidr" {
  name = "/Dreo/cidr"
}

resource "aws_subnet" "nat-al-subnet" {
  count = length(var.nat-al-subnet)
  cidr_block = var.nat-al-subnet[count.index]
  vpc_id = aws_vpc.projvpc.id
  availability_zone = var.availability_zone_pub[count.index]
  map_public_ip_on_launch= true
  tags = {
    Name= var.sn_name_tag_pub[count.index]
  }
}

resource "aws_subnet" "prod-webserver-subnet" {
  count = length(var.prod-webserver-subnet)
  cidr_block = var.prod-webserver-subnet[count.index]
  vpc_id = aws_vpc.projvpc.id
  availability_zone = var.availability_zone_prvt[count.index]
  map_public_ip_on_launch= true
  tags = {
    Name= var.sn_web_tag_prvt[count.index]
  }
}

resource "aws_subnet" "prod-appserver-subnet" {
  count = length(var.prod-appserver-subnet)
  cidr_block = var.prod-appserver-subnet[count.index]
  vpc_id = aws_vpc.projvpc.id
  availability_zone = var.availability_zone_prvt[count.index]
  map_public_ip_on_launch= false
  tags = {
    Name= var.sn_app_tag_prvt[count.index]
  }
}

resource "aws_subnet" "database-subnet" {
  count = length(var.database-subnet)
  cidr_block = var.database-subnet[count.index]
  vpc_id = aws_vpc.projvpc.id
  availability_zone = var.availability_zone_prvt[count.index]
  map_public_ip_on_launch= false
  tags = {
    Name= var.sn_db_tag_prvt[count.index]
  }
}

resource "aws_internet_gateway" "projgw" {
  vpc_id = aws_vpc.projvpc.id
  tags = {
    Name= "venturagw"
  }
}

resource "aws_route_table" "projrt" {
  count = length(var.route-table-tag)
    vpc_id = aws_vpc.projvpc.id
  tags = {
    Name= var.route-table-tag[count.index]
  }
}

resource "aws_route_table_association" "natass" {
  route_table_id = aws_route_table.projrt[0].id
  subnet_id = aws_subnet.nat-al-subnet[0].id
}

resource "aws_route_table_association" "natass1" {
  route_table_id = aws_route_table.projrt[1].id
  subnet_id = aws_subnet.nat-al-subnet[1].id
}

resource "aws_route_table_association" "webass" {
  route_table_id = aws_route_table.projrt[2].id
  subnet_id = aws_subnet.prod-webserver-subnet[0].id
}

resource "aws_route_table_association" "webass1" {
  route_table_id = aws_route_table.projrt[3].id
  subnet_id = aws_subnet.prod-webserver-subnet[1].id
}

resource "aws_route_table_association" "appass" {
  route_table_id = aws_route_table.projrt[4].id
  subnet_id = aws_subnet.prod-appserver-subnet[0].id
}

resource "aws_route_table_association" "appass1" {
  route_table_id = aws_route_table.projrt[5].id
  subnet_id = aws_subnet.prod-appserver-subnet[1].id
}

resource "aws_route_table_association" "dbass" {
  route_table_id = aws_route_table.projrt[6].id
  subnet_id = aws_subnet.database-subnet[0].id
}

resource "aws_route_table_association" "dbass1" {
  route_table_id = aws_route_table.projrt[7].id
  subnet_id = aws_subnet.database-subnet[1].id
}

resource "aws_route" "nat-al_igw" {
  route_table_id = aws_route_table.projrt[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.projgw.id
}

resource "aws_route" "nat-al_igw1" {
  route_table_id = aws_route_table.projrt[1].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.projgw.id
}

resource "aws_route" "webserver_igw" {
  route_table_id = aws_route_table.projrt[2].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.projgw.id
}

resource "aws_route" "webserver_igw1" {
  route_table_id = aws_route_table.projrt[3].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.projgw.id
}

resource "aws_eip" "projeip" {
  count = 2
  vpc = true  
}

resource "aws_nat_gateway" "projnat" {
  subnet_id = aws_subnet.nat-al-subnet[0].id
  connectivity_type = "public"
  allocation_id = aws_eip.projeip[0].allocation_id
}

resource "aws_nat_gateway" "projnat1" {
  subnet_id = aws_subnet.nat-al-subnet[1].id
  connectivity_type = "public"
  allocation_id = aws_eip.projeip[1].allocation_id
}

resource "aws_route" "projroute_ngw" {
  route_table_id = aws_route_table.projrt[4].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.projnat.id
}

resource "aws_route" "projroute_ngw1" {
  route_table_id = aws_route_table.projrt[5].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.projnat1.id
}

