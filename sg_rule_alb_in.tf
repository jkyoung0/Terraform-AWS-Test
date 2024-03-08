### IN-ALB SG Rules ###

# IN-ALB <- WEB
resource "aws_security_group_rule" "alb_in_http_ingress" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  security_group_id        = aws_security_group.alb_in_sg.id
  source_security_group_id = aws_security_group.web_sg.id

  lifecycle { create_before_destroy = true }
}

# IN-ALB -> WAS
resource "aws_security_group_rule" "alb_in_http_was_egress" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  security_group_id        = aws_security_group.alb_in_sg.id
  source_security_group_id = aws_security_group.was_sg.id

  lifecycle { create_before_destroy = true }
}