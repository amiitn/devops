resource "aws_internet_gateway" "public-internet-gateway" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = "test-vpc-internet-gateway"
  }
}