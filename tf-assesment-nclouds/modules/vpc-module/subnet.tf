#public_subnet_1
resource "aws_subnet" "public_sn_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.Public_sn_cidr_1
  availability_zone       = var.public_subnet_az

    tags = merge(
    {
      Name        = "public_subnet_1${var.name}"
      Environment = var.environment
    },
    var.tags
  )
}

#public_subnet_2
resource "aws_subnet" "public_sn_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.Public_sn_cidr_2
  availability_zone       = var.public_subnet_az

    tags = merge(
    {
      Name        = "public_subnet_2${var.name}"
      Environment = var.environment
    },
    var.tags
  )
}

#private_subnet_1
resource "aws_subnet" "private_sn_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.Private_sn_cidr_1
  availability_zone       = var.private_subnet_az_1

    tags = merge(
    {
      Name        = "private_subnet_1_.${var.name}"
      Environment = var.environment
    },
    var.tags
  )
}

#private_subnet_2
resource "aws_subnet" "private_sn_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.Private_sn_cidr_2
  availability_zone       = var.private_subnet_az_2

    tags = merge(
    {
      Name        = "private_subnet_2_${var.name}"
      Environment = var.environment
    },
    var.tags
  )
}
