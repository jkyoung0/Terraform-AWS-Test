# Elastic IP for NAT gateway
resource "aws_eip" "ej_eip" {
  depends_on = [aws_internet_gateway.ej_gw]
  #domain     = "vpc"
  tags = {
    Name = "EJ-EIP-for-NAT"
  }
}

# NAT gateway for private subnets 
# (for the private subnet to access internet - eg. ec2 instances downloading softwares from internet)
resource "aws_nat_gateway" "ej_nat_for_private_subnet" {
  allocation_id = aws_eip.ej_eip.id
  subnet_id     = aws_subnet.ej_pubsubnet_1a.id # nat should be in public subnet

  tags = {
    Name = "EJ NAT for private subnet"
  }

  depends_on = [aws_internet_gateway.ej_gw]
}

# route table - connecting to NAT-WEB
resource "aws_route_table" "ej_rt_web" {
  vpc_id = aws_vpc.ej_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ej_nat_for_private_subnet.id
  }

  tags = { Name = "web-rt"}
}

# associate the route table with web subnet
resource "aws_route_table_association" "ej_rta3" {
  subnet_id      = aws_subnet.ej_privsubnet_2a_web.id
  route_table_id = aws_route_table.ej_rt_web.id
}
resource "aws_route_table_association" "ej_rta4" {
  subnet_id      = aws_subnet.ej_privsubnet_2b_web.id
  route_table_id = aws_route_table.ej_rt_web.id
}

# route table - connecting WEB-WAS
resource "aws_route_table" "ej_rt_was" {
  vpc_id = aws_vpc.ej_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ej_nat_for_private_subnet.id
  }

  tags = { Name = "was-rt"}
}

# associate the route table with web subnet
resource "aws_route_table_association" "ej_rta5" {
  subnet_id      = aws_subnet.ej_privsubnet_2a_was.id
  route_table_id = aws_route_table.ej_rt_was.id
}
resource "aws_route_table_association" "ej_rta6" {
  subnet_id      = aws_subnet.ej_privsubnet_2b_was.id
  route_table_id = aws_route_table.ej_rt_was.id
}
