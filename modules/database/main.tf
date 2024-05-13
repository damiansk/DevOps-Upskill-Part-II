resource "random_password" "database-password" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "db-pass" {
  name = "${var.config.name}-db-main-pass"
}

resource "aws_secretsmanager_secret_version" "db-pass-val" {
  secret_id     = aws_secretsmanager_secret.db-pass.id
  secret_string = random_password.database-password.result
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.config.name}-subnet-group"
  subnet_ids = var.config.subnets
}

resource "aws_db_instance" "main" {
  identifier                = var.config.database.identifier
  allocated_storage         = 5
  engine                    = "mysql"
  engine_version            = "8.0.35"
  instance_class            = "db.t3.micro"
  db_name                   = var.config.database.name
  username                  = var.config.database.user
  password                  = aws_secretsmanager_secret_version.db-pass-val.secret_string
  db_subnet_group_name      = aws_db_subnet_group.main.id
  vpc_security_group_ids    = var.config.security_groups
  skip_final_snapshot       = true
  final_snapshot_identifier = "Ignore"

  depends_on = [aws_db_subnet_group.main]
}
