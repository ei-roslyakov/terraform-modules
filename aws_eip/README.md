## Usage

```hcl
module "eip" {
  source = "./aws_eip"

  name              = "prod-nlb-ip"
  count_eip         = 1
  instance          = "Instance ID (optional)"
  network_interface = "Network interface ID (optional)"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```