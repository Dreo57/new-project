resource "aws_db_subnet_group" "ventura_db_sngp" {
  name       = "ventura-db-subnetgp"
  subnet_ids = [var.database-subnet1, var.database-subnet2]

  tags = {
    Name = "Vntura DB subnet group"
  }
}