# Create DB Subnet Group
resource "aws_db_subnet_group" "this" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.db_subnet_group_name
  }
}

# Create RDS instance
resource "aws_db_instance" "this" {
  identifier              = var.db_identifier
  engine                  = var.engine
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  skip_final_snapshot     = true
  publicly_accessible     = false
}
