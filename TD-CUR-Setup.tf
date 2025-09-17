resource "aws_s3_bucket" "hourly_cur" {
  bucket = "${data.aws_caller_identity.current.account_id}-hourly-cur"






  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_ownership_controls" "hourly_cur" {
  bucket = aws_s3_bucket.hourly_cur.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
resource "aws_s3_bucket_public_access_block" "hourly_cur" {
  bucket = aws_s3_bucket.hourly_cur.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "hourly_cur_sse" {
  bucket = aws_s3_bucket.hourly_cur.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_policy" "hourly_cur_policy" {
  bucket = aws_s3_bucket.hourly_cur.id
  policy = jsonencode({
    Version = "2008-10-17",
    Id      = "Policy1335892530063",
    Statement = [
      {
        Sid       = "Stmt1335892150622",
        Effect    = "Allow",
        Principal = { Service = "billingreports.amazonaws.com" },
        Action    = ["s3:GetBucketAcl", "s3:GetBucketPolicy"],
        Resource  = aws_s3_bucket.hourly_cur.arn,
        Condition = {
          StringEquals = {
            "aws:SourceArn"     = "arn:aws:cur:us-east-1:${data.aws_caller_identity.current.account_id}:definition/*",
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          }
        }
      },
      {
        Sid       = "Stmt1335892526596",
        Effect    = "Allow",
        Principal = { Service = "billingreports.amazonaws.com" },
        Action    = ["s3:PutObject"],
        Resource  = "${aws_s3_bucket.hourly_cur.arn}/*",
        Condition = {
          StringEquals = {
            "aws:SourceArn"     = "arn:aws:cur:us-east-1:${data.aws_caller_identity.current.account_id}:definition/*",
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}

resource "aws_cur_report_definition" "hourly_cur" {
  report_name                = "${data.aws_caller_identity.current.account_id}-hourly-cur"
  time_unit                  = "HOURLY"
  format                     = "textORcsv"
  compression                = "GZIP"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = aws_s3_bucket.hourly_cur.bucket
  s3_prefix                  = "CUR"
  s3_region                  = "us-east-1"
  additional_artifacts       = ["QUICKSIGHT"]
  refresh_closed_reports     = true
  report_versioning          = "CREATE_NEW_REPORT"
  depends_on                 = [aws_s3_bucket.hourly_cur, aws_s3_bucket_policy.hourly_cur_policy]
  lifecycle {
    prevent_destroy = true
  }
}
