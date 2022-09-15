## Usage

```hcl
terraform {
  source = "../../modules/aws_iam_user"
}

inputs = {
  users = {
    "temp.user" = {
      name                      = (Optional, if not presented will be used map key)
      path                      = (Optional, default "/")
      permissions_boundary      = (Optional, default null)
      force_destroy             = (Optional, default false)
      password_reset_required   = (Optional, default true)
      password_length           = (Optional, default, "20")
      policy                    = (Optional, only one ARN is allowed)
      custom_tags = (Optional, f.e {
        Project = "banda"
      }
    }
    "temp.user-2" = {
      name = "temp.user-2"
    }
  }
  tags = {
    Common = "tags"
  }
}
```