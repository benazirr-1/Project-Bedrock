variable "aws_region" {
  description = "The AWS region where resources will be created"
  type = string
  default = "us-east-1"
}

variable "db_username" {
  description = "Username for RDS databases"
  type = string
  default = "innovatemart"
  sensitive = true
}

variable "db_password" {
  description = "Pawssword for RDS databases"
  type = string
  default = "93Innova8emart"
  sensitive = true
}