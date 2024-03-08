### WAS SG Rules ###

# WAS <- IN-ALB
resource "aws_security_group_rule" "was_http_alb_in_ingress" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  security_group_id        = aws_security_group.was_sg.id
  source_security_group_id = aws_security_group.alb_in_sg.id

  lifecycle { create_before_destroy = true }
}

# WAS -> IN-ALB
resource "aws_security_group_rule" "was_http_alb_in_egress" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  security_group_id        = aws_security_group.was_sg.id
  source_security_group_id = aws_security_group.alb_in_sg.id

  lifecycle { create_before_destroy = true }
}