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
  default = ""
}
variable "bucket_name" {
  description = "Bucket_name"
  default     = null
}
variable "s3_origin_id" {
  default = ""
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
variable "default_ttl" {
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header"
  default     = 86400
}
variable "max_ttl" {
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers."
  default     = 31536000
}
variable "min_ttl" {
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds."
  default     = 0
}
variable "smooth_streaming" {
  description = "Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior."
  default     = false
}
variable "minimum_protocol_version" {
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections"
  default     = "TLSv1.2_2019"
}
variable "tags" {
  type    = map(string)
  default = {}
}