## Usage

```hcl
module "rds_cluster_aurora_postgres" {
  source = "./aws_rds_aurora"

  cluster_identifier             = "my-cluster-test"
  create_cluster                 = true
  engine                         = "aurora-postgresql"
  engine_version                 = "12.4"
  cluster_family                 = "aurora-postgresql12"
  cluster_type                   = "global"
  cluster_size                   = 1
  user                           = "admin"
  password                       = "Test123456789"
  db_port                        = 5432
  instance_type                  = "db.r4.large"
  vpc_id                         = "vpc.id
  security_groups                = ["sg-0aa103ee20d20c7ad"]
  allowed_cidr_blocks            = ["172.31.0.0/16"]
  subnets                        = data.aws_subnet_ids.selected.ids
  cloudwatch_alarm_actions_ok    = ["arn:aws:sns:eu-west-2:********************:ok"]
  cloudwatch_alarm_actions_alarm = ["arn:aws:sns:eu-west-2:********************:alarm"]
  global_cluster_identifier = put global_cluster_identifier id

}
```

## For using global type should be created 
```hcl
resource "aws_rds_global_cluster" "this" {
  global_cluster_identifier = "some"
}
```