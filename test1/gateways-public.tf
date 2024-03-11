# Internet Gateway
resource "aws_internet_gateway" "ttest_gw" {
  vpc_id = aws_vpc.ttest_vpc.id
}

# route table for public subnet - connecting to Internet gateway
resource "aws_route_table" "ttest_rt_public" {
  vpc_id = aws_vpc.ttest_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ttest_gw.id
  }
}

# associate the route table with public subnet 1a
resource "aws_route_table_association" "ttest_rta1" {
  subnet_id      = aws_subnet.ttest_pubsubnet_1a.id
  route_table_id = aws_route_table.ttest_rt_public.id
}
# associate the route table with public subnet 2b
resource "aws_route_table_association" "ttest_rta2" {
  subnet_id      = aws_subnet.ttest_pubsubnet_1b.id
  route_table_id = aws_route_table.ttest_rt_public.id
}
