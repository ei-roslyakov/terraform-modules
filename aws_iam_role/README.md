## Usage

```hcl
terraform {
  source = "../../modules/aws_iam_role"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "policies" {
  config_path = "../aws_iam_policies"
}

inputs = {
  roles = {
    "ec2-allow-s3" = {
      name = "ec2-allow-s3"                                   # (Optional, the name of the role, if not present, will be used map key)
      policy_arns = [                                         # (Optional, policy ARNs that grants an entity permission to assume the role, default [])
        "ARN-1",
        "ARN-2"
      ]
      instance_profile_enable = true                          # (Optional, create instance_profile? true or false, default true)
      custom_tags = {                                         # (Optional, key-value map of tags for the role)
        Env = "develop"
      }
    }
    "ecs-allow-s3" = {
      name = "ecs-allow-s3"
      policy_arns = [
        lookup(dependency.policies.outputs.policy_name_with_arn, "full-s3-policy")
      ]
      instance_profile_enable = false
      custom_tags = {
        Env = "prod"
      }
    }
  }
  tags = {
    Company = "NAME"
  }
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_role"></a> [role](#module\_role) | ./iam_role | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_roles"></a> [roles](#input\_roles) | A map of roles with parameters | <pre>map(object({<br>    name                    = optional(string)<br>    path                    = optional(string)<br>    instance_profile_enable = optional(bool)<br>    policy_arns             = optional(list(string))<br>    custom_tags             = optional(map(string))<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy"></a> [policy](#output\_policy) | Role policy document in json format. Outputs always, independent of `enabled` variable |
| <a name="output_role_name_with_arn"></a> [role\_name\_with\_arn](#output\_role\_name\_with\_arn) | The name of the IAM role created |
| <a name="output_role_name_with_id"></a> [role\_name\_with\_id](#output\_role\_name\_with\_id) | The stable and unique string identifying the role |
<!-- END_TF_DOCS -->