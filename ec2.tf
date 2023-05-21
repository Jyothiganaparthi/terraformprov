resource "aws_instance" "publicinstance" {
  ami           =  "ami-024e6efaf93d85776"
  instance_type = "t2.nano"
  key_name = "Key98"
  subnet_id     = aws_subnet.publicsubnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  associate_public_ip_address = true
  tags = {
    Name = var.server_name
  }
}
