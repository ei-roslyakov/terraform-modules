## Usage

```hcl
terraform {
  source = "../terraform-modules/aws_cdn_key_group"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  public_key_comment = "public_key_comment"
  pub_key_file           = "./pub_key.pem"
  public_key_name        = "my-cdn-pub-key"

  key_group_comment   = "key_group_comment"
  key_group_name      = "my-cdn-key-group-name"
}
```
