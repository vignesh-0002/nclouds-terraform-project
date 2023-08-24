#vpc_module
resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(
    {
      Name        = "vpc_${var.name}"
      Environment = var.environment
    },
    var.tags
  )
}

# Custom internet Gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name        = "IGW.${var.name}"
      Environment = var.environment
    },
    var.tags
  )
}

#EIP

resource "aws_eip" "eip" {
    domain   = "vpc"
}

#nat_GW
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_sn_1.id
}

#security_group
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol  = "-1"
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
