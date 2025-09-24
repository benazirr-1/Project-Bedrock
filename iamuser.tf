resource "aws_iam_user" "developer_readonly" {
  name = "developer-readonly"
}

resource "aws_iam_access_key" "developer_readonly_key" {
  user = aws_iam_user.developer_readonly.name
}

output "developer_access_key_id" {
  description = "The access key ID for the read-only developer user."
  value       = aws_iam_access_key.developer_readonly_key.id
}

output "developer_secret_access_key" {
  description = "The secret access key for the read-only developer user."
  value       = aws_iam_access_key.developer_readonly_key.secret
  sensitive   = true
}