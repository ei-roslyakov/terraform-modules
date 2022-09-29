## Usage

```hcl
terraform {
  source = "../../modules/aws_iam_group"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "policies" {
  config_path = "../aws_iam_policies"
}

inputs = {
  groups = {
    "admins" = {
      name = "admins"                                                             # (Optional, the group name, if not present, will be used map key)
      group_users = [                                                             # (Optional, a list of IAM User names to associate with the group, default [])
        "user@user"
      ]
      group_policy_arns = [                                                       # (Optional, the ARNs of the policy you want to apply, default [])
        lookup(dependency.policies.outputs.policy_name_with_arn, "admins-policy")
      ]
    }
    "devs" = {
      name = "devs"
      group_users = [
        "user@user",
        "user2@user"
      ]
      group_policy_arns = [
        lookup(dependency.policies.outputs.policy_name_with_arn, "devs-common-policy")
      ]
    }
  }
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_group"></a> [group](#module\_group) | ./iam_group_with_policies | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_groups"></a> [groups](#input\_groups) | A map of users with parameters | <pre>map(object({<br>    name              = optional(string)<br>    path              = optional(string)<br>    group_users       = optional(list(string))<br>    group_policy_arns = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->