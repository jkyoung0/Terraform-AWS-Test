# ASG with Launch template
resource "aws_launch_template" "ttest_ec2_launch_templ" {
  name_prefix   = "ttest_ec2_launch_templ"
  image_id      = "ami-04599ab1182cd7961" # Amazon Linux 2 AMI (HVM) in ap-northeast-2
  instance_type = "t2.micro"
  user_data     = filebase64("user_data.sh")
  iam_instance_profile { # session manager role
    arn = aws_iam_instance_profile.ttest-resources-iam-profile.arn
  }

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.ttest_privsubnet_2b.id
    security_groups             = [aws_security_group.ttest_sg_for_ec2.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ttest-instance" # Name for the EC2 instances
    }
  }
}

resource "aws_autoscaling_group" "ttest_asg" {
  # no of instances
  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  # Connect to the target group
  target_group_arns = [aws_lb_target_group.ttest_alb_tg.arn]

  vpc_zone_identifier = [ # Creating EC2 instances in private subnet
    aws_subnet.ttest_privsubnet_2b.id
  ]

  launch_template {
    id      = aws_launch_template.ttest_ec2_launch_templ.id
    version = "$Latest"
  }
}

resource "aws_iam_instance_profile" "ttest-resources-iam-profile" {
  name = "ttest_ec2_profile"
  role = aws_iam_role.ttest-resources-iam-role.name
}

resource "aws_iam_role" "ttest-resources-iam-role" {
  name               = "ttest-ssm-role"
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
    stack = "ttest"
  }
}

resource "aws_iam_role_policy_attachment" "ttest-resources-ssm-policy" {
  role       = aws_iam_role.ttest-resources-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
