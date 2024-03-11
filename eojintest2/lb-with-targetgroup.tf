# External ALB
resource "aws_lb" "ej_lb_ex" {
  name               = "ej-ex-lb-asg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ej_sg_for_elb_ex.id]
  subnets            = [aws_subnet.ej_pubsubnet_1a.id, aws_subnet.ej_pubsubnet_1b.id]
  depends_on         = [aws_internet_gateway.ej_gw]
  
}

resource "aws_lb_target_group" "ej_alb_tg_ex" { #타겟 인스턴스 매핑은 ec2 파일에서 
  name     = "ej-alb-tg-ex"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ej_vpc.id
}

resource "aws_lb_listener" "ej_front_end" {
  load_balancer_arn = aws_lb.ej_lb_ex.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ej_alb_tg_ex.arn
  }
}


# # Internal ALB
# resource "aws_lb" "ej_lb_in" {
#   name               = "ej-in-lb-asg"
#   internal           = true
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.ej_sg_for_elb_in.id]
#   subnets            = [aws_subnet.ej_privsubnet_2a_web.id, aws_subnet.ej_privsubnet_2b_web.id]  
# }

# resource "aws_lb_target_group" "ej_alb_tg_in" {
#   name     = "ej-alb-tg-in"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.ej_vpc.id
# }

# resource "aws_lb_listener" "ej_back_end" {
#   load_balancer_arn = aws_lb.ej_lb_in.arn
#   port              = "80"
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.ej_alb_tg_in.arn
#   }
# }