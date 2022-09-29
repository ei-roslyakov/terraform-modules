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
| <a name="module_user"></a> [user](#module\_user) | ./iam_user | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_users"></a> [users](#input\_users) | A map of users with parameters | <pre>map(object({<br>    name                    = optional(string)<br>    path                    = optional(string)<br>    permissions_boundary    = optional(string)<br>    force_destroy           = optional(bool)<br>    password_reset_required = optional(bool)<br>    password_length         = optional(string)<br>    custom_tags             = optional(map(string))<br>    policy                  = optional(list(string))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_user_name_with_arn"></a> [user\_name\_with\_arn](#output\_user\_name\_with\_arn) | IAM user name |
| <a name="output_user_name_with_password"></a> [user\_name\_with\_password](#output\_user\_name\_with\_password) | IAM user name |
| <a name="output_user_name_with_unique_id"></a> [user\_name\_with\_unique\_id](#output\_user\_name\_with\_unique\_id) | IAM user name |
<!-- END_TF_DOCS -->