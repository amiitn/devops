resource "aws_route_table_association" "public-subnet-association" {
  count = length(var.cidr_public_subnet)
  depends_on = [aws_subnet.test-vpc-public-subnets, aws_route_table.public-route-table]
  subnet_id      = element(aws_subnet.test-vpc-public-subnets[*].id, count.index)
  route_table_id = aws_route_table.public-route-table.id
}


resource "aws_route_table_association" "private-subnet-association" {
  count = length(var.cidr_private_subnet)
  depends_on = [aws_subnet.test-vpc-private-subnets, aws_route_table.private-route-table]
  subnet_id      = element(aws_subnet.test-vpc-private-subnets[*].id, count.index)
  route_table_id = aws_route_table.private-route-table[count.index].id
}