resource "aws_lb" "ttest_lb" {
  name               = "ttest-lb-asg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ttest_sg_for_elb.id]
  subnets            = [aws_subnet.ttest_pubsubnet_1a.id, aws_subnet.ttest_pubsubnet_1b.id]
  depends_on         = [aws_internet_gateway.ttest_gw]
}

resource "aws_lb_target_group" "ttest_alb_tg" {
  name     = "ttest-tf-lb-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ttest_vpc.id
}

resource "aws_lb_listener" "ttest_front_end" {
  load_balancer_arn = aws_lb.ttest_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ttest_alb_tg.arn
  }
}
