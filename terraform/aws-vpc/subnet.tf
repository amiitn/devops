# Setup public subnet
resource "aws_subnet" "test-vpc-public-subnets" {
  count      = length(var.cidr_public_subnet)
  vpc_id     = aws_vpc.test-vpc.id
  cidr_block = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "test-vpc-public-subnet-${count.index + 1}"
  }
}

# Setup private subnet
resource "aws_subnet" "test-vpc-private-subnets" {
  count      = length(var.cidr_private_subnet)
  vpc_id     = aws_vpc.test-vpc.id
  cidr_block = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "test-vpc-private-subnet-${count.index + 1}"
  }
}