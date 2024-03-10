### WEB SG Rules ###

# WEB <- EX-ALB
resource "aws_security_group_rule" "web_http_alb_ex_ingress" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = aws_security_group.alb_ex_sg.id

  lifecycle { create_before_destroy = true }
}

# WEB -> EX-ALB
resource "aws_security_group_rule" "web_http_alb_ex_egress" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = aws_security_group.alb_ex_sg.id

  lifecycle { create_before_destroy = true }
}

# WEB -> IN-ALB
resource "aws_security_group_rule" "web_http_alb_in_egress" {
  type              = "egress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "TCP"
  security_group_id = aws_security_group.web_sg.id
  # source_security_group_id = aws_security_group.alb_in_sg.id
  source_security_group_id = aws_security_group.was_sg.id

  lifecycle { create_before_destroy = true }
}