### VPC ###
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  #  enable_dns_hostnames = true                    # DNS Hostname 사용 옵션, 기본은 false
  tags = { Name = "trrf-vpc" }
}

### Internet Gateway ###
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "trrf-IGW" }
}


### NAT Gateway ###
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.sub_pub1.id

  tags = { Name = "trrf-NAT" }
}