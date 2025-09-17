resource "aws_iam_role" "sie" {
  name = "SIE"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:${data.aws_partition.current.partition}:iam::${var.external_account_sie}:root"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = var.external_id_sie
          }
        }
      }
    ]
  })
  managed_policy_arns = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/ReadOnlyAccess"
  ]
}

output "billing_software_role_arn" {
  description = "ARN of the IAM Role"
  value       = aws_iam_role.sie.arn
}

output "billing_software_role_id" {
  description = "Id of the IAM Role"
  value       = aws_iam_role.sie.unique_id
}
