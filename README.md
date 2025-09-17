

<!-- BEGIN_TF_DOCS -->
# opentofu-module-aws-td-synnex

OpenTofu Module to bootstrap TD Synnex (https://www.tdsynnex.com) access to AWS Root Organizations.

Original cloudformation templates provided by TD Synnex can be found here within `raw-cloudformation-templates/` folder

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cur_report_definition.hourly_cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cur_report_definition) | resource |
| [aws_iam_role.cloudanalyst](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sie](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_s3_bucket.hourly_cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.hourly_cur_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.hourly_cur_sse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_external_account_cloudanalyst"></a> [external\_account\_cloudanalyst](#input\_external\_account\_cloudanalyst) | TD CloudOps Account for CloudAnalyst Role | `string` | `"687056495944"` | no |
| <a name="input_external_account_sie"></a> [external\_account\_sie](#input\_external\_account\_sie) | External Account for SIE Role | `string` | `"328676173091"` | no |
| <a name="input_external_id_sie"></a> [external\_id\_sie](#input\_external\_id\_sie) | External Id for SIE Role | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_billing_software_role_arn"></a> [billing\_software\_role\_arn](#output\_billing\_software\_role\_arn) | ARN of the IAM Role |
| <a name="output_billing_software_role_id"></a> [billing\_software\_role\_id](#output\_billing\_software\_role\_id) | Id of the IAM Role |
| <a name="output_cloudanalyst_role_arn"></a> [cloudanalyst\_role\_arn](#output\_cloudanalyst\_role\_arn) | ARN of the IAM Role |
| <a name="output_cloudanalyst_role_id"></a> [cloudanalyst\_role\_id](#output\_cloudanalyst\_role\_id) | Id of the IAM Role |
<!-- END_TF_DOCS -->