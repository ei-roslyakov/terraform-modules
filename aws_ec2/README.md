## Usage

```hcl
module "ec2" {
  source = ""

  name                                = "Name for instance"
  create_default_security_group       = false 
  defaulf_sg_source_security_group_id = "SG id for source ingress role(if create_default_security_group = false not required)"
  allowed_ports                       = ["80"] # (if create_default_security_group = false not required)
  instance_type                       = "t2.micro"
  ssh_key_pair                        = "key_name"
  monitoring                          = true
  vpc_id                              = "vpc_id"
  subnet_id                           = "subnet_id"
  security_group                      = ["sg that will be attached to instance"]

  root_block_device = [
    {
      volume_type           = "gp2"
      delete_on_termination = true
      volume_size           = 10
    },
  ]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```