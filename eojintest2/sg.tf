# EX-ALB
resource "aws_security_group" "ej_sg_for_elb_ex" {
  name   = "ej-sg-for-elb-ex"
  vpc_id = aws_vpc.ej_vpc.id

  ingress {
    description      = "Allow http request from anywhere"
    protocol         = "tcp"
    from_port        = 80
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow https request from anywhere"
    protocol         = "tcp"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "ej_sg_for_web" {
  name   = "ej-sg-for-web"
  vpc_id = aws_vpc.ej_vpc.id

  ingress {
    description     = "Allow http request from Load Balancer"
    protocol        = "tcp"
    from_port       = 80 # range of
    to_port         = 80 # port numbers
    security_groups = [aws_security_group.ej_sg_for_elb_ex.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IN-ALB
resource "aws_security_group" "ej_sg_for_elb_in" {
  name   = "ej-sg-for-elb-in"
  vpc_id = aws_vpc.ej_vpc.id

  ingress {
    description     = "Allow http request from WEB"
    protocol        = "tcp"
    from_port       = 80 # range of
    to_port         = 80 # port numbers
    security_groups = [aws_security_group.ej_sg_for_web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ej_sg_for_was" {
  name   = "ej-sg-for-was"
  vpc_id = aws_vpc.ej_vpc.id
  depends_on = [ aws_security_group.ej_sg_for_elb_in ]

  ingress {
    description     = "Allow http request from IN Load balancer"
    protocol        = "tcp"
    from_port       = 80 # range of
    to_port         = 80 # port numbers
    security_groups = [aws_security_group.ej_sg_for_elb_in.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

