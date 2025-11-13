output "rds_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "secret_arn" {
  value = aws_secretsmanager_secret.db_secret.arn
}

output "generated_password" {
  value     = random_password.db_password.result
  sensitive = true
}
