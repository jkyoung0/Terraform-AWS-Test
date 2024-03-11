resource "aws_alb" "alb_ex" {
  name                             = "ex-alb"
  internal                         = false
  load_balancer_type               = "application"
  subnets                          = [aws_subnet.sub_pub1.id, aws_subnet.sub_pub2.id]
  security_groups                  = [aws_security_group.alb_ex_sg.id]
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "trrf-ex-alb"
  }
}

resource "aws_alb_target_group" "alb_ex_tg" {
  name     = "trrf-ex-alb-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    port                = 8080
    interval            = 15
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_alb_target_group_attachment" "tgt_web1" {
  target_group_arn = aws_alb_target_group.alb_ex_tg.arn
  target_id        = aws_instance.web1.id
  port             = 8080
}

resource "aws_alb_target_group_attachment" "tgt_web2" {
  target_group_arn = aws_alb_target_group.alb_ex_tg.arn
  target_id        = aws_instance.web2.id
  port             = 8080
}

resource "aws_lb_listener" "alb_lstn_ex" {
  load_balancer_arn = aws_alb.alb_ex.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_ex_tg.arn
  }
}


# ### Internal ALB ###
# resource "aws_lb" "alb_in" {
#   name               = "alb-in"
#   internal           = true #internal
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.alb_in_sg.id]
#   subnets            = [aws_subnet.sub_prv1.id, aws_subnet.sub_prv2.id]
#   tags               = { Name = "trrf-alb-in" }
# }

# resource "aws_alb_target_group" "alb_in_tgt" {
#   name        = "alb-in-tgt"
#   port        = 80
#   protocol    = "HTTP"
#   target_type = "instance"
#   vpc_id      = aws_vpc.vpc.id
# }

# resource "aws_alb_target_group_attachment" "tgt_was1" {
#   target_group_arn = aws_alb_target_group.alb_in_tgt.arn
#   target_id        = aws_instance.was1.id
#   port             = 80
# }

# resource "aws_alb_target_group_attachment" "tgt_was2" {
#   target_group_arn = aws_alb_target_group.alb_in_tgt.arn
#   target_id        = aws_instance.was2.id
#   port             = 80
# }

# resource "aws_alb_listener" "alb_lstn_in" {
#   load_balancer_arn = aws_lb.alb_in.arn
#   port              = 80
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.alb_in_tgt.arn
#   }
# }
