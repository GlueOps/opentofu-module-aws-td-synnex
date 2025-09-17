resource "aws_iam_role" "cloudanalyst" {
  name = "TD-CloudAnalyst-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:${data.aws_partition.current.partition}:iam::${var.external_account_cloudanalyst}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSOrganizationsReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSSupportAccess",
    "arn:aws:iam::aws:policy/job-function/Billing",
    "arn:aws:iam::aws:policy/IAMUserChangePassword"
  ]
}

data "aws_partition" "current" {}

output "cloudanalyst_role_arn" {
  description = "ARN of the IAM Role"
  value       = aws_iam_role.cloudanalyst.arn
}

output "cloudanalyst_role_id" {
  description = "Id of the IAM Role"
  value       = aws_iam_role.cloudanalyst.unique_id
}
