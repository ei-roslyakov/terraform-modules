## Usage

```hcl
module "security_group" {
    source        = "../aws_sg"

    name          = "my-sg"
    vpc_id        = "vpc-id"
    ingress_rules = {
      {
        port        = 80
        protocol    = "tcp"
        cidr_blocks = ["192.168.1.1/32", "192.168.1.2/32"]
        description = "description-1"
      },
      {
        port        = 443
        protocol    = "tcp"
        security_groups = ["sg-id-1", "sg-id-2"]
        description = "description2"
      },
    }
}
```
