## Usage

```hcl
inputs = {

  identitystore_user = [
    {
      user_name = "eugene@example.com"
      given_name = "Yevhenii"
      family_name = "Rosliakov"
      email = "eugene@example.com"
      groups = [
        "Administrators",
      ]
    },
    {
      user_name = "alexander@example.com"
      given_name = "Alexander"
      family_name = "Example"
      email = "alexander@example.com"
      groups = [
        "Engineering",
      ]
    }
  ]

  identitystore_group = {
    "Administrators" = {
      display_name = "Administrators"
      description = "Allow Full Access to the account"
    }
    "Engineering" = {
      display_name = "Engineering"
      description = "Engineering team"
    }
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

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_identitystore_group.group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/identitystore_group) | resource |
| [aws_identitystore_group_membership.group_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/identitystore_group_membership) | resource |
| [aws_identitystore_user.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/identitystore_user) | resource |
| [aws_ssoadmin_instances.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_identitystore_group"></a> [identitystore\_group](#input\_identitystore\_group) | A map of users with parameters | <pre>map(object({<br>    display_name = optional(string)<br>    description  = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_identitystore_user"></a> [identitystore\_user](#input\_identitystore\_user) | A map of users with parameters | <pre>list(object({<br>    display_name  = optional(string)<br>    user_name     = optional(string)<br>    given_name    = optional(string)<br>    family_name   = optional(string)<br>    email         = optional(string)<br>    groups        = optional(list(string))<br>    primary_email = optional(bool)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_user_group_pairs"></a> [user\_group\_pairs](#output\_user\_group\_pairs) | n/a |
<!-- END_TF_DOCS -->