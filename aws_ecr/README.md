## Usage

```hcl
module "aws_ecr" {
  source = ""

  image_names = [
    "r-image-dev",
    "r-image-test",
    "r-image-prod"
  ]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```
