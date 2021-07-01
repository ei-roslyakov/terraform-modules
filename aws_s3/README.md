## Usage

```hcl
module "s3_bucket" {
  source = "./aws_s3"

  create_bucket = var.create_bucket

  bucket                  = var.bucket
  acl                     = var.acl
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
  force_destroy           = false

  ignore_changes = "replication_configuration"

  replication_configuration = {
    role = aws_iam_role.replication.arn
    rules = var.replication_rules
  }

  versioning = {
    enabled = true
  }
  cors_rule = var.cors_rule
}
```
### Be aware that this module has lifecycle rule with ignore_changes = replication_configuration
