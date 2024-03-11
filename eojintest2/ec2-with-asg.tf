# ASG with Launch template
resource "aws_launch_template" "ej_ec2_launch_templ_web" {
  name_prefix   = "ej_ec2_launch_templ_web"
  image_id      = "ami-0eb5115914ccc4bc2" # Amazon Linux 2 AMI in us-west-2
  instance_type = "t2.micro"
  user_data     = filebase64("user_data.sh")
  iam_instance_profile { # session manager role
    arn = aws_iam_instance_profile.ej_resource_iam_profile.arn
  }
  network_interfaces {
    associate_public_ip_address = false
    # subnet_id                   = aws_subnet.ej_privsubnet_2a_web.id  # Multi-AZ 구성을 위해 주석, ASG에 Subnet 지정
    security_groups             = [aws_security_group.ej_sg_for_web.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ej-web-instance" # Name for the EC2 instances
    }
  }
}

# resource "aws_launch_template" "ej_ec2_launch_templ_was" {
#   name_prefix   = "ej_ec2_launch_templ_was"
#   image_id      = "ami-0eb5115914ccc4bc2" # Amazon Linux 2 AMI in us-west-2
#   instance_type = "t2.micro"
#   user_data     = filebase64("user_data.sh")
#   iam_instance_profile { # session manager role
#     arn = aws_iam_instance_profile.ej_resource_iam_profile.arn
#   }
#   network_interfaces {
#     associate_public_ip_address = false
#     subnet_id                   = aws_subnet.ej_privsubnet_2a_was.id
#     security_groups             = [aws_security_group.ej_sg_for_was.id]
#   }
#   tag_specifications {
#     resource_type = "instance"
#     tags = {
#       Name = "ej-was-instance" # Name for the EC2 instances
#     }
#   }
# }

# ASG for WEB
resource "aws_autoscaling_group" "ej_asg_web" {
  # no of instances
  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  # Connect to the target group
  target_group_arns = [aws_lb_target_group.ej_alb_tg_ex.arn]

  vpc_zone_identifier = [ # Creating EC2 instances in private subnet
    aws_subnet.ej_privsubnet_2a_web.id, aws_subnet.ej_privsubnet_2b_web.id
  ]

  launch_template {
    id      = aws_launch_template.ej_ec2_launch_templ_web.id
    version = "$Latest"
  }
}

# # ASG for WAS
# resource "aws_autoscaling_group" "ej_asg_was" {
#   # no of instances
#   desired_capacity = 2
#   max_size         = 3
#   min_size         = 1

#   # # Connect to the target group
#   # target_group_arns = [aws_lb_target_group.ej_alb_tg.arn]

#   vpc_zone_identifier = [ # Creating EC2 instances in private subnet
#     aws_subnet.ej_privsubnet_2a_was.id
#   ]

#   launch_template {
#     id      = aws_launch_template.ej_ec2_launch_templ_was.id
#     version = "$Latest"
#   }
# }

resource "aws_iam_instance_profile" "ej_resource_iam_profile" {
  name = "ej-ec2-profile"
  role = aws_iam_role.ej_resource_iam_role.name
}

resource "aws_iam_role" "ej_resource_iam_role" {
  name               = "ej-ssm-role"
  description        = "The role for the developer resources EC2"
  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": {
        "Effect": "Allow",
        "Principal": {"Service": "ec2.amazonaws.com"},
        "Action": "sts:AssumeRole"
      }
    }
  EOF

  tags = {
    stack = "ej"
  }
}

resource "aws_iam_role_policy_attachment" "ej_resources_ssm_policy" {
  role       = aws_iam_role.ej_resource_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


