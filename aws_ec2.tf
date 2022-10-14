
#Create Security Group
resource "aws_security_group" "tcs_app_sg" {
  name = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.tcs.id

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_app"
  }
}




#Launch Instance
resource "aws_instance" "tcs_instance" {
  ami           = "ami-079bf9b52f2e091e2"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tcs_pub_sb.id
  key_name      = "aws"
  count = 1
  vpc_security_group_ids = [ aws_security_group.tcs_app_sg.id ]
  user_data = file("ecomm.sh")
  
  tags = {
    Name = "tf_ec2"
  }
  }
