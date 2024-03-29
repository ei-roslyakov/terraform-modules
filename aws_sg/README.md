## Usage

```hcl
inputs = {
  groups = {
    "${local.common.project}-sg" = {
      name   = "${local.common.project}-sg"
      vpc_id = dependency.data.outputs.aws_vpc_id
      ingress_rules = [
        {
          from_port       = 22
          to_port         = 22
          protocol        = "tcp"
          cidr_blocks     = ["213.110.148.240/32"]
          security_groups = []
          description     = "allow ssh roslyakov"
        },
        {
          from_port       = 13549
          to_port         = 13549
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = []
          description     = "allow https roslyakov"
        }
      ]
      tags = {
        Terraform   = "true"
        Environment = "qa"
      }
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The security group description. | `string` | `"Instance default security group (only egress access is allowed)."` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | Ingress rules that will be attached to the SG | `any` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC that the instance security group belongs to. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | IDs on the AWS Security Groups associated with the instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the security group |
<!-- END_TF_DOCS -->
