# Terraform Modules

Personal collection of Terraform modules and wrappers on top of existing modules, used across various infrastructure projects.

## Modules

### AWS

| Module | Description |
|--------|-------------|
| [aws-acm](./aws-acm) | ACM certificate management |
| [aws-cdn-key-group](./aws-cdn-key-group) | CloudFront key group |
| [aws-cloudfront](./aws-cloudfront) | CloudFront distribution |
| [aws-ec2](./aws-ec2) | EC2 instances |
| [aws-ec2-instance-profile](./aws-ec2-instance-profile) | EC2 instance profiles |
| [aws-ecr](./aws-ecr) | Elastic Container Registry |
| [aws-ecs-svc](./aws-ecs-svc) | ECS service |
| [aws-ecs-td](./aws-ecs-td) | ECS task definition |
| [aws-eip](./aws-eip) | Elastic IP |
| [aws-elasticsearch](./aws-elasticsearch) | Elasticsearch / OpenSearch |
| [aws-globalaccelerator](./aws-globalaccelerator) | Global Accelerator |
| [aws-iam-group](./aws-iam-group) | IAM groups with policies |
| [aws-iam-oidc-github](./aws-iam-oidc-github) | IAM OIDC provider for GitHub Actions |
| [aws-iam-policy](./aws-iam-policy) | IAM policies |
| [aws-iam-role](./aws-iam-role) | IAM roles |
| [aws-iam-user](./aws-iam-user) | IAM users |
| [aws-identitystore-user-groups](./aws-identitystore-user-groups) | Identity Store users and groups |
| [aws-rds-aurora](./aws-rds-aurora) | RDS Aurora clusters |
| [aws-redis](./aws-redis) | ElastiCache Redis |
| [aws-route53-alias](./aws-route53-alias) | Route53 alias records |
| [aws-route53-health-check](./aws-route53-health-check) | Route53 health checks |
| [aws-route53-record](./aws-route53-record) | Route53 DNS records |
| [aws-s3](./aws-s3) | S3 buckets |
| [aws-s3-cdn-policy](./aws-s3-cdn-policy) | S3 bucket policy for CloudFront |
| [aws-sg](./aws-sg) | Security groups |
| [aws-sns](./aws-sns) | SNS topics |
| [aws-vpc](./aws-vpc) | VPC |

### Azure

| Module | Description |
|--------|-------------|
| [azure-rg](./azure-rg) | Resource groups |

### Cloudflare

| Module | Description |
|--------|-------------|
| [cloudflare-tunnel-wrap](./cloudflare-tunnel-wrap) | Cloudflare Tunnel wrapper |

### MongoDB Atlas

| Module | Description |
|--------|-------------|
| [atlas-mongodb](./atlas-mongodb) | MongoDB Atlas clusters |

## Usage

```hcl
module "example" {
  source = "git::https://github.com/ei-roslyakov/terraform-modules.git//aws-vpc?ref=main"

  # module variables
}
```
