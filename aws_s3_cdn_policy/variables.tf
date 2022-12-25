variable "bucket" {
    description = "The name of the bucket to which to apply the policy."
    default = ""
}

variable "iam_arn" {
    description = "A pre-generated ARN for use in S3 bucket policies (see below). Example: arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E2QWRUHAPOMQZL"
    default = ""
}

