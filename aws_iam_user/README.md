## Usage

```hcl
terraform {
  source = "../../modules/aws_iam_user"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  users = {
    "user@user" = {              
      name = "user@user"                       # (Optional, if not presented will be used map key)
      path = "/"                               # (Optional, path in which to create the user, default "/")
      policy =  [                              # (Optional, the policy ARN that will be attached to the IAM user)
        "ARN")                                 
        ]
      custom_tags = {                          # (Optional, key-value map of tags for the IAM user)
        Admin = "true"
      }
    }
    "user2@user" = {
      name = "user2@user"
      custom_tags = {
        Admin = "false"
      }
    }
    "user3@user" = {
      name = "user3@user" 
      custom_tags = {
        Admin = "false"
      }
    }
  }
  tags = {                                     # (Optional, key-value map of tags for all IAM user)     
    User = "true"
  }
}
```