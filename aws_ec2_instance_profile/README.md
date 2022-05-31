```hcl
# Instance profile using existing managed policies
module "managed_profile" {
  source      = "./aws_ec2_instance_profile"
  name        = "Name"
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]
}
```