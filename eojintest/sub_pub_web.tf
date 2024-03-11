### Subnet Public ###
resource "aws_subnet" "sub_pub1" {
  vpc_id                  = aws_vpc.vpc.id # 어느 vpc와 연결할 것인지 지정
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true # Public IP 자동 할당
  tags                    = { Name = "trrf-sub-pub-1" }
}

resource "aws_subnet" "sub_pub2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.20.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true
  tags                    = { Name = "trrf-sub-pub-2" }
}

### Public Routing ###
resource "aws_route_table" "rtb_pub1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "trrf-pub1" }
}

resource "aws_route_table_association" "routing_pub1" {
  subnet_id      = aws_subnet.sub_pub1.id
  route_table_id = aws_route_table.rtb_pub1.id
}

resource "aws_route_table" "rtb_pub2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "trrf-pub2" }
}

resource "aws_route_table_association" "routing_pub2" {
  subnet_id      = aws_subnet.sub_pub2.id
  route_table_id = aws_route_table.rtb_pub2.id
}
