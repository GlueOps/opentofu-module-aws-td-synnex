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
}


resource "aws_iam_role_policy_attachment" "cloudanalyst_org_readonly" {
  role       = aws_iam_role.cloudanalyst.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AWSOrganizationsReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "cloudanalyst_support_access" {
  role       = aws_iam_role.cloudanalyst.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AWSSupportAccess"
}

resource "aws_iam_role_policy_attachment" "cloudanalyst_billing" {
  role       = aws_iam_role.cloudanalyst.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/job-function/Billing"
}

resource "aws_iam_role_policy_attachment" "cloudanalyst_change_password" {
  role       = aws_iam_role.cloudanalyst.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/IAMUserChangePassword"
}

output "cloudanalyst_role_arn" {
  description = "ARN of the IAM Role"
  value       = aws_iam_role.cloudanalyst.arn
}

output "cloudanalyst_role_id" {
  description = "Id of the IAM Role"
  value       = aws_iam_role.cloudanalyst.unique_id
}
