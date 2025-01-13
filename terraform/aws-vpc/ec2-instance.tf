data "aws_subnet" "public-subnet" {
  filter {
    name = "tag:Name"
    values = ["test-vpc-public-subnet-1"]
  }

  depends_on = [
    aws_route_table_association.public-subnet-association
  ]
}

resource "aws_security_group" "test-vpc-ec2-sg" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress                = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
  vpc_id = aws_vpc.test-vpc.id
  depends_on = [aws_vpc.test-vpc]
  tags = {
    Name = "test-vpc-ec2-sg"
  }
}

resource "aws_instance" "test-vpc-ec2" {
  ami = "ami-053b12d3152c0cc71"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  tags = {
    Name = "ec2-test-vpc-public-subnet-1"
  }
  key_name= "aws_key"
  subnet_id = data.aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.test-vpc-ec2-sg.id]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa <!-- RSA-PUBLIC-KEY --!> ubuntu@amit-local"
}


output "output-ec2-public-ip" {
  value = aws_instance.test-vpc-ec2.public_ip
}