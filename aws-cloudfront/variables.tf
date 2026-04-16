variable "create_cloudfront" {
  description = "Controls if cloudfront_distribution resources should be created"
  type        = bool
  default     = true
}
variable "aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution."
  type        = list(string)
  default     = null
}
variable "create_record" {
  description = "Controls if route53 record resources should be created"
  type        = bool
  default     = false
}
variable "evaluate_target_health" {
  description = "Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set. Some resources have special requirements"
  type        = bool
  default     = false
}
variable "viewer_certificate" {
  description = "The SSL configuration for this distribution"
  type        = any
  default = {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1"
  }
}
variable "zone_record" {
  type    = string
  default = null
}
variable "private_zone" {
  type        = bool
  default     = false
  description = "Search filter for Route53 zone, if private set true"
}
variable "zone_name" {
  type        = string
  description = "The Hosted Zone name of the desired Hosted Zone"
  default     = ""
}
variable "bucket_name" {
  description = "Bucket_name"
  default     = null
}
variable "s3_origin_id" {
  default = ""
}
variable "origin_path" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginPath
  type        = string
  description = "An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. It must begin with a /. Do not add a / at the end of the path."
  default     = ""
}
variable "custom_header" {
  type = list(object({
    name  = string
    value = string
  }))

  description = "List of one or more custom headers passed to the origin"
  default     = []
}
variable "cache_policy_id" {
  type        = string
  default     = null
  description = "ID of the cache policy attached to the cache behavior"
}

variable "origin_request_policy_id" {
  type        = string
  default     = null
  description = "ID of the origin request policy attached to the cache behavior"
}
variable "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL."
  default     = ""
}
variable "s3_bucket_arn" {
  description = "The ARN of the bucket"
  default     = ""
}
variable "is_ipv6_enabled" {
  default = false
}
variable "http_version" {
  description = "The maximum HTTP version to support on the distribution. Allowed values are http1.1 and http2. The default is http2."
  default     = "http2"
}
variable "price_class" {
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  default     = "PriceClass_100"
}
variable "viewer_protocol_policy" {
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https"
  default     = "redirect-to-https"
}
variable "allowed_methods" {
  default = [
    "GET",
    "HEAD",
    "OPTIONS",
  ]
}
variable "cached_methods" {
  default = [
    "GET",
    "HEAD",
    "OPTIONS",
  ]
}
variable "compress" {
  description = "Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)."
  default     = true
}
variable "smooth_streaming" {
  description = "Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior."
  default     = false
}
variable "minimum_protocol_version" {
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections"
  default     = "TLSv1.2_2019"
}
variable "logging_config" {
  description = "The logging configuration that controls how logs are written to your distribution (maximum one)."
  type        = any
  default     = {}
}
variable "headers_cache_keys" {
  description = "Specifies the cache headers for default cache behavior."
  type        = list(string)
  default     = []
}
variable "realtime_logging_config" {
  description = "The real-time log configuration that is attached to cache behavior."
  type = object({
    name               = string
    sampling_rate      = number
    fields             = list(string)
    kinesis_stream_arn = string
  })
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "forward_headers" {
  description = "Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify `*` to include all headers."
  type        = list(string)
  default     = []
}
variable "forward_query_string" {
  type        = bool
  default     = false
  description = "Forward query strings to the origin that is associated with this cache behavior"
}
variable "forward_cookies" {
  type        = string
  description = "Specifies whether you want CloudFront to forward cookies to the origin. Valid options are all, none or whitelist"
  default     = "none"
}

variable "forward_cookies_whitelisted_names" {
  type        = list(string)
  description = "List of forwarded cookie names"
  default     = []
}