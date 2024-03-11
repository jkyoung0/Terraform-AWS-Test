### Subnet Private ###
resource "aws_subnet" "sub_prv1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = false
  tags                    = { Name = "trrf-sub-was-1" }
}

resource "aws_subnet" "sub_prv2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.21.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = false
  tags                    = { Name = "trrf-sub-was-2" }
}

### Private Routing ###
resource "aws_route_table" "rtb_prv1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = { Name = "trrf-prv1" }
}

resource "aws_route_table_association" "routing_prv1" {
  subnet_id      = aws_subnet.sub_prv1.id
  route_table_id = aws_route_table.rtb_prv1.id
}

resource "aws_route_table" "rtb_prv2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = { Name = "trrf-prv2" }
}

resource "aws_route_table_association" "trrf-routing-prv2" {
  subnet_id      = aws_subnet.sub_prv2.id
  route_table_id = aws_route_table.rtb_prv2.id
}
