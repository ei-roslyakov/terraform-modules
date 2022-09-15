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