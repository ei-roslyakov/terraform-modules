## Usage

```hcl
module "ec2" {
  source = ""

  name                                = "Name for instance"
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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.ec2_cpu_credit_util](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.ec2_cpu_util](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_eip.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ports"></a> [allowed\_ports](#input\_allowed\_ports) | List of allowed ingress ports | `list` | `[]` | no |
| <a name="input_ami"></a> [ami](#input\_ami) | ID of AMI to use for the instance | `string` | `""` | no |
| <a name="input_assign_eip_address"></a> [assign\_eip\_address](#input\_assign\_eip\_address) | Assign an Elastic IP address to the instance | `bool` | `false` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | If true, the EC2 instance will have associated public IP address | `bool` | `false` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability Zone the instance is launched in. If not set, will be launched in the first AZ of the region | `string` | `""` | no |
| <a name="input_cpu_credit_threshold"></a> [cpu\_credit\_threshold](#input\_cpu\_credit\_threshold) | CPU Credit Amount Threshold | `number` | `0` | no |
| <a name="input_cpu_threshold"></a> [cpu\_threshold](#input\_cpu\_threshold) | CPU Utilization Threshold | `number` | `0` | no |
| <a name="input_create_default_security_group"></a> [create\_default\_security\_group](#input\_create\_default\_security\_group) | Create default Security Group with only Egress traffic allowed | `string` | `"true"` | no |
| <a name="input_defaulf_sg_source_security_group_id"></a> [defaulf\_sg\_source\_security\_group\_id](#input\_defaulf\_sg\_source\_security\_group\_id) | The IDs of the security groups that will be added to sg rule | `string` | `""` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | Enable EC2 Instance Termination Protection | `string` | `"false"` | no |
| <a name="input_ebs_block_device"></a> [ebs\_block\_device](#input\_ebs\_block\_device) | Additional EBS block devices to attach to the instance | `list(map(string))` | `[]` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | Launched EC2 instance will be EBS-optimized | `string` | `"false"` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. | `string` | `""` | no |
| <a name="input_instance_enabled"></a> [instance\_enabled](#input\_instance\_enabled) | Flag to control the instance creation. Set to false if it is necessary to skip instance creation | `string` | `"true"` | no |
| <a name="input_instance_initiated_shutdown_behavior"></a> [instance\_initiated\_shutdown\_behavior](#input\_instance\_initiated\_shutdown\_behavior) | Shutdown behavior for the instance | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance | `string` | `"t2.micro"` | no |
| <a name="input_ipv6_address_count"></a> [ipv6\_address\_count](#input\_ipv6\_address\_count) | Number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet | `string` | `"0"` | no |
| <a name="input_ipv6_addresses"></a> [ipv6\_addresses](#input\_ipv6\_addresses) | List of IPv6 addresses from the range of the subnet to associate with the primary network interface | `list` | `[]` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on all resources as prefix | `string` | n/a | yes |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | Private IP address to associate with the instance in the VPC | `string` | `""` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | Customize details about the root block device of the instance. See Block Devices below for details | `list(map(string))` | `[]` | no |
| <a name="input_security_group"></a> [security\_group](#input\_security\_group) | List of Security Group IDs | `list` | `[]` | no |
| <a name="input_ssh_key_pair"></a> [ssh\_key\_pair](#input\_ssh\_key\_pair) | The key name to use for the instance | `string` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The VPC Subnet ID to launch in | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_tg_unhealthy_alarm_actions"></a> [tg\_unhealthy\_alarm\_actions](#input\_tg\_unhealthy\_alarm\_actions) | arn for sns topic | `string` | `""` | no |
| <a name="input_tg_unhealthy_ok_actions"></a> [tg\_unhealthy\_ok\_actions](#input\_tg\_unhealthy\_ok\_actions) | arn for sns topic | `string` | `""` | no |
| <a name="input_treat_missing_data"></a> [treat\_missing\_data](#input\_treat\_missing\_data) | n/a | `string` | `"breaching"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user\_data\_base64 instead. | `string` | `null` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | Can be used instead of user\_data to pass base64-encoded binary data directly. Use this instead of user\_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC that the instance security group belongs to | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Disambiguated ID of the instance |
| <a name="output_private_dns"></a> [private\_dns](#output\_private\_dns) | Private DNS of instance |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP of instance |
| <a name="output_role"></a> [role](#output\_role) | Name of AWS IAM Role associated with the instance |
| <a name="output_ssh_key_pair"></a> [ssh\_key\_pair](#output\_ssh\_key\_pair) | Name of the SSH key pair provisioned on the instance |
<!-- END_TF_DOCS -->