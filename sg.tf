### Web Security Group ###
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "allow 22, 8080"
  vpc_id      = aws_vpc.vpc.id
}


### WAS Security Group ###
resource "aws_security_group" "was_sg" {
  name        = "was-sg"
  description = "allow 22, 8080"
  vpc_id      = aws_vpc.vpc.id
}


### DB SG ###
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "allow 22, 8080"
  vpc_id      = aws_vpc.vpc.id
}


### EX-ALB SG ###
resource "aws_security_group" "alb_ex_sg" {
  name        = "ex-alb-sg"
  description = "allow 80, 443"
  vpc_id      = aws_vpc.vpc.id
}

### IN-ALB SG ###
resource "aws_security_group" "alb_in_sg" {
  name        = "in-alb-sg"
  description = "allow 80,443"
  vpc_id      = aws_vpc.vpc.id
}