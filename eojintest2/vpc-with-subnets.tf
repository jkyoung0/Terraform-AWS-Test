# VPC
resource "aws_vpc" "ej_vpc" {
  cidr_block = "10.0.0.0/16" 
  tags = { Name = "trr-vpc" }
}

# Creating 1st public subnet 
resource "aws_subnet" "ej_pubsubnet_1a" {
  vpc_id                  = aws_vpc.ej_vpc.id
  cidr_block              = "10.0.0.0/27" #32 IPs
  map_public_ip_on_launch = true          # public subnet
  availability_zone       = "us-west-2a"
  tags = { Name = "pub1"}
}

# Creating 2nd public subnet 
resource "aws_subnet" "ej_pubsubnet_1b" {
  vpc_id                  = aws_vpc.ej_vpc.id
  cidr_block              = "10.0.0.32/27" #32 IPs
  map_public_ip_on_launch = true           # public subnet
  availability_zone       = "us-west-2b"
  tags = { Name = "pub2"}
}

# Creating web private subnet 
resource "aws_subnet" "ej_privsubnet_2a_web" {
  vpc_id                  = aws_vpc.ej_vpc.id
  cidr_block              = "10.0.11.0/24" #32 IPs
  map_public_ip_on_launch = false         # private subnet
  availability_zone       = "us-west-2a"
  tags = { Name = "web1"}
}

resource "aws_subnet" "ej_privsubnet_2b_web" {
  vpc_id                  = aws_vpc.ej_vpc.id
  cidr_block              = "10.0.21.0/24" #32 IPs
  map_public_ip_on_launch = false         # private subnet
  availability_zone       = "us-west-2b"
  tags = { Name = "web2"}
}

# Creating was private subnet 
resource "aws_subnet" "ej_privsubnet_2a_was" {
  vpc_id                  = aws_vpc.ej_vpc.id
  cidr_block              = "10.0.12.0/24" #32 IPs
  map_public_ip_on_launch = false         # private subnet
  availability_zone       = "us-west-2a"
  tags = { Name = "was1"}
}

resource "aws_subnet" "ej_privsubnet_2b_was" {
  vpc_id                  = aws_vpc.ej_vpc.id
  cidr_block              = "10.0.22.0/24" #32 IPs
  map_public_ip_on_launch = false         # private subnet
  availability_zone       = "us-west-2b"
  tags = { Name = "was2"}
}