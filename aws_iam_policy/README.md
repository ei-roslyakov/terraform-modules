## Usage

```hcl
terraform {
  source = "../../modules/aws_iam_policy"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  policies = {
    "devs-common" = {
      name = "devs-common"                            # (Optional, the name of the policy, if not present, will be used map key)
      policy_path = "./policies/devs-common.json"     # (Required, The path for the policy JSON file)
      description = "The policy for banda dev team"   # (Optional, if not present, will be used policy name)
    }
    "admins" = {
      name = "admins"
      policy_path = "./policies/admins.json"
      description = "The policy for banda admins"
    }
    "roslyakov-s3" = {
      policy_path = "./policies/roslyakov-s3.json"
      description = "The policy for roslyako to access s3"
      custom_tags = {
        ivanov = false
      }
    }
    "full-s3" = {
      name = "full-s3"
      policy_path = "./policies/full-s3.json"
      description = "Allow all for s3"
    }
  }
  tags = {
    Common = "tags"
  }
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_policies"></a> [policies](#input\_policies) | A map of policies with parameters | <pre>map(object({<br>    name        = optional(string)<br>    path        = optional(string)<br>    policy_path = optional(string)<br>    custom_tags = optional(map(string))<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_name_with_arn"></a> [policy\_name\_with\_arn](#output\_policy\_name\_with\_arn) | IAM user name |
| <a name="output_policy_name_with_id"></a> [policy\_name\_with\_id](#output\_policy\_name\_with\_id) | IAM user name |
<!-- END_TF_DOCS -->