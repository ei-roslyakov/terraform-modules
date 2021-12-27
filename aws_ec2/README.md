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
### If you want to add CloudWatch Alarms
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
  
  cpu_threshold              = 50.0 // CPU Utilization threshold (alarm if cpu usage is >= 50% for last 15 minutes)
  cpu_credit_threshold       = 200.0 // CPU Credit Balance threshold (alarm if <= 200 cpu credits remaining for last 15 minutes) for t2/t3 instances
  tg_unhealthy_ok_actions    = "arn:aws:sns:eu-west-2:123456789123:alarm-ok" // don't forget to set the real SNS topic ARN
  tg_unhealthy_alarm_actions = "arn:aws:sns:eu-west-2:123456789123:alarm-alarm" // don't forget to set the real SNS topic ARN
}
```
