#Public_Route Table and RT asso for the Custom VPC
resource "aws_route_table" "public_rt_1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.RT_cidr
    gateway_id = aws_internet_gateway.IGW.id
  }

   tags = merge(
    {
      Name        = "public_rt_1${var.name}"
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_route_table_association" "public-rt" {
  subnet_id      = aws_subnet.public_sn_1.id
  route_table_id = aws_route_table.public_rt_1.id
}

#Public_Route_2 Table and RT asso for the Custom VPC 
resource "aws_route_table" "public_rt_2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.RT_cidr
    gateway_id = aws_internet_gateway.IGW.id
  }

   tags = merge(
    {
      Name        = "public_rt_2${var.name}"
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_route_table_association" "public-rt_2" {
  subnet_id      = aws_subnet.public_sn_2.id
  route_table_id = aws_route_table.public_rt_2.id
}

#private_route_table and RT asso for the Custom VPC 

resource "aws_route_table" "private_rt_1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.RT_cidr
    nat_gateway_id = aws_nat_gateway.gw.id
  }

   tags = merge(
    {
      Name        = "private_rt_1${var.name}"
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_route_table_association" "private-rt" {
  subnet_id      = aws_subnet.private_sn_1.id
  route_table_id = aws_route_table.private_rt_1.id
}


#private_route_table_2 and RT asso for the Custom VPC 

resource "aws_route_table" "private_rt_2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.RT_cidr
    nat_gateway_id = aws_nat_gateway.gw.id
  }

   tags = merge(
    {
      Name        = "private_rt_2${var.name}"
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_route_table_association" "private-rt_2" {
  subnet_id      = aws_subnet.private_sn_2.id
  route_table_id = aws_route_table.private_rt_2.id
}