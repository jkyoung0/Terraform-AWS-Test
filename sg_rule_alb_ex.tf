### EX-ALB SG Rules ###

# EX-ALB <- HTTP
resource "aws_security_group_rule" "alb_ex_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_ex_sg.id

  lifecycle { create_before_destroy = true }
}

# EX-ALB <- HTTPS
resource "aws_security_group_rule" "alb_ex_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_ex_sg.id

  lifecycle { create_before_destroy = true }
}

# EX-ALB -> HTTP
resource "aws_security_group_rule" "alb_ex_http_egress" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_ex_sg.id

  lifecycle { create_before_destroy = true }
}

# EX-ALB -> HTTPS
resource "aws_security_group_rule" "alb_ex_https_egress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_ex_sg.id

  lifecycle { create_before_destroy = true }
}