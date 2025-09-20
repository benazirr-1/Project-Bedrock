# This security group correctly links to the main VPC
resource "aws_security_group" "rds_sg" {
  name        = "innovatemart-rds-sg"
  description = "Allow inbound traffic from VPC to RDS instances"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "innovatemart-rds-sg"
  }
}

# NEW: This explicitly tells RDS which subnets to use
resource "aws_db_subnet_group" "main" {
  name       = "innovatemart-db-subnet-group"
  subnet_ids = aws_subnet.private.*.id # Uses the private subnets from vpc.tf

  tags = {
    Name = "InnovateMart DB Subnet Group"
  }
}

# UPDATED: The database now references the subnet group
resource "aws_db_instance" "postgres_db" {
  identifier             = "innovatemart-orders-db"
  engine                 = "postgres"
  engine_version         = "17" # Using a known stable version
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "orders"
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name # Added this line
  skip_final_snapshot    = true
  publicly_accessible  = false
}

# UPDATED: The database now references the subnet group
resource "aws_db_instance" "mysql_db" {
  identifier             = "innovatemart-catalog-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "catalog"
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name # Added this line
  skip_final_snapshot    = true
  publicly_accessible  = false
}