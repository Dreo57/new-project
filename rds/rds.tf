resource "aws_db_instance" "drebase" {
  allocated_storage    = 30
  engine               = var.engine
  engine_version       = "8.0.28"
  instance_class       = var.instance_class
  db_name              = "phpappdatabase"
  username             = var.username
  password             = var.password
  storage_type         = "gp3"
  skip_final_snapshot  = true
  multi_az = true
  publicly_accessible = false
  vpc_security_group_ids = [var.rds_db_sg]
  db_subnet_group_name = var.database-dbsubnet
  
}

