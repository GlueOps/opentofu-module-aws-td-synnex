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
}

resource "aws_iam_role_policy_attachment" "sie_readonly_access" {
  role       = aws_iam_role.sie.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/ReadOnlyAccess"
}

output "billing_software_role_arn" {
  description = "ARN of the IAM Role"
  value       = aws_iam_role.sie.arn
}

output "billing_software_role_id" {
  description = "Id of the IAM Role"
  value       = aws_iam_role.sie.unique_id
}
