resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public-internet-gateway.id
  }
  tags = {
    Name = "test-vpc-public-route-table"
  }
}

resource "aws_route_table" "private-route-table" {
  count      = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.test-vpc.id
  depends_on = [aws_nat_gateway.nat_gateway]
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }
  tags = {
    Name = "test-vpc-private-route-table-${count.index + 1}"
  }
}