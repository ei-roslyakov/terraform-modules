locals {
  s3_origin_id = "S3-${join(" ", var.bucket_name)}"
}

resource "aws_cloudfront_origin_access_identity" "access_identity" {
  count   = var.create_cloudfront ? 1 : 0
  comment = "access-identity-${join(" ", var.bucket_name)}.s3.amazonaws.com"
}

resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  count = var.create_cloudfront ? 1 : 0

  aliases         = var.aliases
  enabled         = true
  http_version    = var.http_version
  is_ipv6_enabled = var.is_ipv6_enabled
  price_class     = var.price_class
  tags = merge(
    {
      "Name" = format("%s", local.s3_origin_id)
    },
    var.tags,
  )

  default_cache_behavior {
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    compress               = var.compress
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
    min_ttl                = var.min_ttl
    smooth_streaming       = var.smooth_streaming
    target_origin_id       = local.s3_origin_id
    trusted_signers        = []
    viewer_protocol_policy = var.viewer_protocol_policy

    forwarded_values {
      headers = [
        "Access-Control-Request-Headers",
        "Access-Control-Request-Method",
        "Origin",
      ]
      query_string            = false
      query_string_cache_keys = []

      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
  }

  origin {
    domain_name = join(" ", var.bucket_regional_domain_name)
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = join(" ", aws_cloudfront_origin_access_identity.access_identity.*.cloudfront_access_identity_path)
      # origin_access_identity = aws_cloudfront_origin_access_identity.access_identity.*.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      locations = [
      ]
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = lookup(var.viewer_certificate, "acm_certificate_arn", null)
    cloudfront_default_certificate = lookup(var.viewer_certificate, "cloudfront_default_certificate", null)
    iam_certificate_id             = lookup(var.viewer_certificate, "iam_certificate_id", null)
    minimum_protocol_version       = lookup(var.viewer_certificate, "minimum_protocol_version", "TLSv1.2_2019")
    ssl_support_method             = lookup(var.viewer_certificate, "ssl_support_method", null)
  }

  depends_on = [aws_cloudfront_origin_access_identity.access_identity]
}


data "aws_iam_policy_document" "s3_policy_documen" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${join(" ", var.s3_bucket_arn)}/*"]

    principals {
      type        = "AWS"
      identifiers = [join(" ", aws_cloudfront_origin_access_identity.access_identity.*.iam_arn)]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = join(" ", var.bucket_name)
  policy = data.aws_iam_policy_document.s3_policy_documen.json
}

