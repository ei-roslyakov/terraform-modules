```hcl
# Instance profile using existing managed policies
module "managed_profile" {
  source      = "./aws_ec2_instance_profile"
  name        = "Name"
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attached_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_cwagent_policy"></a> [attach\_cwagent\_policy](#input\_attach\_cwagent\_policy) | Toggles attachment of the CloudWatchAgentServerPolicy policy to allow usage of CloudWatch agent | `string` | `false` | no |
| <a name="input_attach_ssm_policy"></a> [attach\_ssm\_policy](#input\_attach\_ssm\_policy) | Toggles attachment of the AmazonSSMManagedInstanceCore policy to allow usage of AWS SSM | `string` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Prefix (eg. abc) of the instance profile (abcProfile) and role (abcRole) names | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path for the instance profile, role and user-managed policy (if any) | `string` | `"/"` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | ARNs of IAM policies for the role | `list(any)` | `[]` | no |
| <a name="input_policy_jsons"></a> [policy\_jsons](#input\_policy\_jsons) | Valid JSON policies for the role | `list(any)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags that should be assigned to the created resources whenever possible | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_profile_name"></a> [profile\_name](#output\_profile\_name) | Instance profile name |
<!-- END_TF_DOCS -->