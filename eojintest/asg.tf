### Launch Configuration ###
resource "aws_launch_configuration" "lc" {
  image_id        = "ami-052c9ea013e6e3567"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web_sg.id]

  lifecycle {
    create_before_destroy = true # ASG에서 EC2 인스턴스를 삭제하기 전 먼저 새로운 인스턴스 생성
  }
}


### WEB Autoscaling Group ###
resource "aws_autoscaling_group" "asg_web" {
  launch_configuration = aws_launch_configuration.lc.name
  vpc_zone_identifier  = [aws_subnet.sub_pub1.id, aws_subnet.sub_pub2.id]

  min_size = 1
  max_size = 3

  # ALB 연결
  health_check_type = "ELB"
  target_group_arns = [aws_alb_target_group.alb_ex_tg.arn]

  tag {
    key                 = "Name"
    value               = "trrf-asg-web"
    propagate_at_launch = true
  }
}

# resource "aws_autoscaling_attachment" "asg_attachment_web" {
#   autoscaling_group_name = aws_autoscaling_group.asg_web.id
#   lb_target_group_arn    = aws_lb.alb_ex.arn
# }

# ### WAS Autoscaling Group ###
# resource "aws_autoscaling_group" "asg_was" {
#   launch_configuration = aws_launch_configuration.lc.name
#   vpc_zone_identifier  = [aws_subnet.sub_prv1.id, aws_subnet.sub_prv2.id]

#   min_size = 1
#   max_size = 3

#   # ALB 연결
#   health_check_type = "ALB"
#   target_group_arns = [aws_alb_target_group.alb_in_tgt.arn]

#   tag {
#     key                 = "Name"
#     value               = "trrf-asg-was"
#     propagate_at_launch = true
#   }
# }

# # resource "aws_autoscaling_attachment" "asg_attachment_was" {
# #   autoscaling_group_name = aws_autoscaling_group.asg_was.id
# #   lb_target_group_arn    = aws_lb.alb_in.arn
# # }