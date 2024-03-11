# ### DB SG Rules ###

# # DB <- WAS
# resource "aws_security_group_rule" "db_http_was_ingress" {
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "TCP"
#   security_group_id        = aws_security_group.db_sg.id
#   source_security_group_id = aws_security_group.was_sg.id

#   lifecycle { create_before_destroy = true }
# }

# # DB -> WAS
# resource "aws_security_group_rule" "db_http_was_egress" {
#   type                     = "egress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "TCP"
#   security_group_id        = aws_security_group.db_sg.id
#   source_security_group_id = aws_security_group.was_sg.id

#   lifecycle { create_before_destroy = true }
# }