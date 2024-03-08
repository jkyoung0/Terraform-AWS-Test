### Subnet Group ###
resource "aws_db_subnet_group" "rds_subgrp" {
  name = "trrf-rds-subgrp"
  subnet_ids = [
    aws_subnet.sub_prv3.id,
    aws_subnet.sub_prv4.id,
  ]
  tags = { Name = "trrf-db-sub-grp" }
}


### RDS ###
resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  db_name                = "trrfRds"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  username               = "lej"
  password               = "eojinlee"
  skip_final_snapshot    = true
  vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
  db_subnet_group_name   = aws_db_subnet_group.rds_subgrp.name
  publicly_accessible    = false
  multi_az               = true
  tags                   = { Name = "trrf-db-rds" }
}
