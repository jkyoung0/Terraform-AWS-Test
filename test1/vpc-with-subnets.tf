# VPC
resource "aws_vpc" "ttest_vpc" {
  cidr_block = "10.0.0.0/23" # 512 IPs 
  tags = {
    Name = "ttest-vpc"
  }
}

# Creating 1st public subnet 
resource "aws_subnet" "ttest_pubsubnet_1a" {
  vpc_id                  = aws_vpc.ttest_vpc.id
  cidr_block              = "10.0.0.0/27" #32 IPs
  map_public_ip_on_launch = true          # public subnet
  availability_zone       = "ap-northeast-2a"
}

# Creating 2nd public subnet 
resource "aws_subnet" "ttest_pubsubnet_1b" {
  vpc_id                  = aws_vpc.ttest_vpc.id
  cidr_block              = "10.0.0.32/27" #32 IPs
  map_public_ip_on_launch = true           # public subnet
  availability_zone       = "ap-northeast-2b"
}

# Creating 1st private subnet 
resource "aws_subnet" "ttest_privsubnet_2b" {
  vpc_id                  = aws_vpc.ttest_vpc.id
  cidr_block              = "10.0.1.0/27" #32 IPs
  map_public_ip_on_launch = false         # private subnet
  availability_zone       = "ap-northeast-2a"
}
