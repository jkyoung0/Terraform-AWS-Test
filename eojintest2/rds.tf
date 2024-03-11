### Subnet Group ###
resource "aws_db_subnet_group" "ej_rds_subgrp" {
  name = "trrf-rds-subgrp"
  subnet_ids = [
    aws_subnet.ej_privsubnet_2a_db.id,
    aws_subnet.ej_privsubnet_2b_db.id
  ]
  tags = { Name = "trrf-db-sub-grp" }
}


### RDS ###
resource "aws_db_instance" "ej_rds" {
  allocated_storage      = 20
  db_name                = "trrfRds"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  username               = "lej"
  password               = "eojinlee"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.ej_sg_for_db.id]
  db_subnet_group_name   = aws_db_subnet_group.ej_rds_subgrp.name
  publicly_accessible    = false
  multi_az               = true
  tags                   = { Name = "trrf-db-rds" }
}
