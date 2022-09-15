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