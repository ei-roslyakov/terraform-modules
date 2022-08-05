## Usage

```hcl
provider "aws" {
  profile = "sph-dev"
  region  = "eu-west-2"
}


module "sns" {
  source = "./aws_sns"

  name = "temp"
  subscribers = {
    opsgenie = {
      protocol               = "email"
      endpoint               = "eugene.roslyakov@example.com"
      endpoint_auto_confirms = true
      raw_message_delivery   = false
    }
  }
}
```