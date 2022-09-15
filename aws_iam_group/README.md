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