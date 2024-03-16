provider "aws" {
  region = var.region
}

module "vpc" {
  source                    = "./modules/vpc"
  project_name              = var.project_name
  environment               = var.environment
  vpc_id                    = module.vpc.vpc_id
  vpc_cidr                  = var.vpc_cidr
  public_subnets            = var.public_subnets
  private_subnets           = var.private_subnets
  database_subnets          = var.database_subnets
  availability_zones        = var.availability_zones
  cidr_block                = var.cidr_block_any
  route_table_id            = var.route_table_id
  gateway_id                = module.vpc.gateway_id
  subnet_id                 = var.subnet_id
  id_app                    = module.ec2_launch_template.app_id
  load_balancer_type        = var.load_balancer_type
  app_alb                   = var.app_alb
  alb_internal              = var.alb_internal
  load_balancer_arn         = var.load_balancer_arn
  alb_listener_port         = var.alb_listener_port
  alb_listener_protocol     = var.alb_listener_protocol
  alb_listener_type         = var.alb_listener_type
  alb_target_group_arn      = var.alb_target_group_arn
  alb_target_group          = var.alb_target_group
  alb_target_group_port     = var.alb_target_group_port
  alb_target_group_protocol = var.alb_target_group_protocol
  app_autoscaling_group     = var.app_autoscaling_group
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  db_subnet_group_name      = var.db_subnet_group_name
  alb_security_group_name   = var.alb_security_group_name
  app_security_group_name   = var.app_security_group_name
  db_security_group_name    = var.db_security_group_name
  alb_security_group        = module.vpc.alb_security_group
  app_security_group        = var.app_security_group
}

module "ec2_launch_template" {
  source             = "./modules/ec2_launch_template"
  project_name       = var.project_name
  environment        = var.environment
  image_id           = var.image_id
  instance_type      = var.instance_type
  app_security_group = module.vpc.app_security_group
  name_prefix        = var.name_prefix
  key_name           = var.key_name
  connection_type    = var.connection_type
  connection_user    = var.connection_user
  connection_host    = var.connection_host
}
