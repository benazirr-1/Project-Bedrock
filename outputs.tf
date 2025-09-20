output "eks_cluster_name" {
  description = "The name of the EKS cluster."
  value       = aws_eks_cluster.main.name
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster's API server."
  value       = aws_eks_cluster.main.endpoint
}

output "rds_postgres_endpoint" {
  description = "The endpoint of the RDS PostgreSQL instance."
  value       = aws_db_instance.postgres_db.endpoint
}

output "rds_mysql_endpoint" {
  description = "The endpoint of the RDS MySQL instance."
  value       = aws_db_instance.mysql_db.endpoint
}

