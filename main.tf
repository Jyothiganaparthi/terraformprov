resource "aws_vpc" "main" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = var.subnet_name
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
   tags = {
    Name = var.route_name
  }
}
resource "aws_route_table_association" "ra" {
  subnet_id      = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.route.id
}
resource "aws_security_group" "sg" {
  name        = "sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.sg_name
  }
}