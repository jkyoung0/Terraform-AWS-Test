### WEB ###
resource "aws_instance" "web1" {
  ami           = "ami-052c9ea013e6e3567"
  instance_type = "t2.micro"
  #  key_name = "#keyname"
  subnet_id              = aws_subnet.sub_pub1.id
  vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]
  tags                   = { Name = "trrf-web-1" }
}

resource "aws_instance" "web2" {
  ami           = "ami-052c9ea013e6e3567"
  instance_type = "t2.micro"
  #  key_name = "#keyname"
  subnet_id              = aws_subnet.sub_pub2.id
  vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]
  tags                   = { Name = "trrf-web-2" }
}

### WAS ###
resource "aws_instance" "was1" {
  ami           = "ami-052c9ea013e6e3567"
  instance_type = "t2.micro"
  #  key_name = "#keyname"
  subnet_id              = aws_subnet.sub_prv1.id
  vpc_security_group_ids = ["${aws_security_group.was_sg.id}"]
  tags                   = { Name = "trrf-was-1" }
}

resource "aws_instance" "was2" {
  ami           = "ami-052c9ea013e6e3567"
  instance_type = "t2.micro"
  #  key_name = "#keyname"
  subnet_id              = aws_subnet.sub_prv2.id
  vpc_security_group_ids = ["${aws_security_group.was_sg.id}"]
  tags                   = { Name = "trrf-was-2" }
}
