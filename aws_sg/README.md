## Usage

```hcl
module "security_group" {
    source        = "./aws_sg"
    name          = "security-group-temp"
    vpc_id        = "vpc-2ba9c143"
    allowed_ip    = ["172.16.0.0/16", "10.0.0.0/16"]
    allowed_ports = [22, 27017]
}
```
