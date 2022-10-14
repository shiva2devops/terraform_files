
#Resource
resource "aws_vpc" "tcs" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "TCS"
  }
}

#Public Subnets
resource "aws_subnet" "tcs_pub_sb" {
  vpc_id                  = aws_vpc.tcs.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "TCS_PUB_SB"
  }
}

#Private subnet
resource "aws_subnet" "tcs_pvt_sb" {
  vpc_id            = aws_vpc.tcs.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "TCS_PVT_SUB"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "tcs_igw" {
  vpc_id = aws_vpc.tcs.id

  tags = {
    Name = "TCS_IGW"
  }
}

#Public Route Table
resource "aws_route_table" "tcs_pub_rt" {
  vpc_id = aws_vpc.tcs.id

  tags = {
    Name = "TCS_PUB_RT"
  }
}

output "aws_route_table_pub_id" {
  value = "aws_route_table.tcs_pub_rt.id"
}

resource "aws_route" "public_internet_geteway" {
  route_table_id         = aws_route_table.tcs_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tcs_igw.id
}


#Private Route Table
resource "aws_route_table" "tcs_pvt_rt" {
  vpc_id = aws_vpc.tcs.id

  tags = {
    Name = "TCS_PVT_RT"
  }
}

#Public Route Table Association
resource "aws_route_table_association" "tcs_pub_assoc" {
  subnet_id      = aws_subnet.tcs_pub_sb.id
  route_table_id = aws_route_table.tcs_pub_rt.id
}

#Private Route Table Association
resource "aws_route_table_association" "tcs_pvt_assoc" {
  subnet_id      = aws_subnet.tcs_pvt_sb.id
  route_table_id = aws_route_table.tcs_pvt_rt.id
}




