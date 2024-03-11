### Subnet Private ###
resource "aws_subnet" "sub_prv3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.12.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = false
  tags                    = { Name = "trrf-sub-db-1" }
}

resource "aws_subnet" "sub_prv4" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.22.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = false
  tags                    = { Name = "trrf-sub-db-2" }
}
