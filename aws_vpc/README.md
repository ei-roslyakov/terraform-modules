## Usage

```hcl
module "vpc" {
  source = "./aws_vpc"

  name = "roslyakov-vpc"
  cidr_block = "10.0.0.0/16"

  azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  one_nat_gateway_per_az = true
  single_nat_gateway = false

  enable_s3_endpoint = true

  tags = {
    Terraform = "true"
    Environment = "test"
  }
}
```

Based on https://github.com/terraform-aws-modules/terraform-aws-vpc