#RDS Resources
resource "aws_db_subnet_group" "mysql-subnet_groups" {
  name                       =  var.subnet_grp_name
  subnet_ids                 = [var.Private_subnet_1,var.Private_subnet_2]
}

#create a RDS Database Instance
resource "aws_db_instance" "EMS_OPS_" {
  engine                     = var.engine
  identifier                 = var.identifier
  allocated_storage          = var.allocated_storage
  engine_version             = var.engine_version
  instance_class             = var.instance_class
  username                   = var.username
  password                   = var.password
  parameter_group_name       = aws_db_parameter_group.default.name
  #vpc_security_group_ids     = [var.ems_ops_private_sg]
  skip_final_snapshot        = var.skip_final_snapshot
  publicly_accessible        = var.publicly_accessible
}


resource "aws_db_parameter_group" "default" {
  name   = var.rds_pg_name
  family = var.rds_family

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}
