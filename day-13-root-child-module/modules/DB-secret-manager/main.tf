# Step 1: Generate a random password
resource "random_password" "db_password" {
  length           = 16
  special          = true
  #override_characters = "!@#%&*"
}

# Step 2: Create a Secrets Manager secret
resource "aws_secretsmanager_secret" "db_secret" {
  name = "${var.db_identifier}-credentials"
  description = "RDS credentials for ${var.db_identifier}"
}

# Step 3: Store username + generated password in the secret
resource "aws_secretsmanager_secret_version" "db_secret_value" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = var.username
    password = random_password.db_password.result
  })
}

# Step 4: Create DB subnet group
resource "aws_db_subnet_group" "this" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.db_subnet_group_name
  }
}

# Step 5: Create RDS instance using the generated password
resource "aws_db_instance" "this" {
  identifier              = var.db_identifier
  engine                  = var.engine
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  db_subnet_group_name    = aws_db_subnet_group.this.name
  username                = var.username
  password                = random_password.db_password.result
  skip_final_snapshot     = true
  publicly_accessible     = false
}
