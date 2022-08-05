## Usage

```hcl
module "globalaccelerator" {
  source = "./aws_globalaccelerator"

  create_globalaccelerator_accelerator = true
  name                                 = "somename"
  create_elb_listener                  = true
  endpoint_group_region                = "eu-west-2"
  endpoint_configuration = {
    endpoint_id = data.aws_lb.test.arn
    weight      = 100
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```
