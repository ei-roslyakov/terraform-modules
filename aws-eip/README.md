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
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_count_eip"></a> [count\_eip](#input\_count\_eip) | Quantity of eip that will be created | `string` | `""` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | EC2 instance ID | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the EIP resource | `string` | `""` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | Network interface ID to associate with | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | `{}` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | Boolean if the EIP is in a VPC or not | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Contains the EIP allocation ID |
| <a name="output_public_dns"></a> [public\_dns](#output\_public\_dns) | Public DNS associated with the Elastic IP address |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Contains the public IP address |
<!-- END_TF_DOCS -->