resource "aws_lb" "alb_ex" {
  name               = "ex-alb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.sub_pub1.id, aws_subnet.sub_pub2.id]
  security_groups = [aws_security_group.alb_ex_sg.id]

  tags = {
    Name = "trrf-ex-alb"
  }
}

resource "aws_lb_listener" "alb_lstn_ex" {
  load_balancer_arn = aws_lb.alb_ex.arn
  port              = 80
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found - TF Study"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "alb_ex_tg" {
  name = "trrf-ex-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "alb_ex_rule" {
  listener_arn = aws_lb_listener.alb_lstn_ex.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ex_tg.arn
  }
}

output "alb_ex_dns" {
  value       = aws_lb.alb_ex.dns_name
  description = "The DNS Address of the ALB"
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
