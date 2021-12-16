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

  dynamic "logging_config" {
    for_each = length(keys(var.logging_config)) == 0 ? [] : [var.logging_config]

    content {
      bucket          = logging_config.value["bucket"]
      prefix          = lookup(logging_config.value, "prefix", null)
      include_cookies = lookup(logging_config.value, "include_cookies", null)
    }
  }

  default_cache_behavior {
    allowed_methods          = var.allowed_methods
    cached_methods           = var.cached_methods
    compress                 = var.compress
    cache_policy_id          = var.cache_policy_id
    origin_request_policy_id = var.origin_request_policy_id
    smooth_streaming         = var.smooth_streaming
    target_origin_id         = local.s3_origin_id
    trusted_signers          = []
    viewer_protocol_policy   = var.viewer_protocol_policy
    realtime_log_config_arn  = try(join("", aws_cloudfront_realtime_log_config.realtime_log.*.arn), null)

    dynamic "forwarded_values" {
      # If a cache policy or origin request policy is specified, we cannot include a `forwarded_values` block at all in the API request
      for_each = try(coalesce(var.cache_policy_id), null) == null && try(coalesce(var.origin_request_policy_id), null) == null ? [true] : []
      content {
        headers = var.forward_headers

        query_string = var.forward_query_string

        cookies {
          forward           = var.forward_cookies
          whitelisted_names = var.forward_cookies_whitelisted_names
        }
      }
    }
  }

  origin {
    domain_name = join(" ", var.bucket_regional_domain_name)
    origin_id   = local.s3_origin_id
    origin_path = var.origin_path

    s3_origin_config {
      origin_access_identity = join(" ", aws_cloudfront_origin_access_identity.access_identity.*.cloudfront_access_identity_path)
    }

    dynamic "custom_header" {
      for_each = var.custom_header
      content {
        name  = custom_header.value.name
        value = custom_header.value.value
      }
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

  tags = merge(
    {
      "Name" = format("%s", local.s3_origin_id)
    },
    var.tags,
  )

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

resource "aws_iam_role" "cloudfront_realtime_log_role" {
  count = var.realtime_logging_config == null ? 0 : 1

  name = "${var.realtime_logging_config.name}-role"
  tags = var.tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CloudFrontRealTimeLogAssumeRole"
        Effect = "Allow"
        Action = [
          "sts:AssumeRole"
        ]
        Principal = {
          "Service" = "cloudfront.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "default"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "kinesis:DescribeStreamSummary",
            "kinesis:DescribeStream",
            "kinesis:PutRecord",
            "kinesis:PutRecords"
          ]
          Resource = [
            var.realtime_logging_config.kinesis_stream_arn
          ]
        }
      ]
    })
  }
}

resource "aws_cloudfront_realtime_log_config" "realtime_log" {
  count = var.realtime_logging_config == null ? 0 : 1

  name          = var.realtime_logging_config.name
  sampling_rate = var.realtime_logging_config.sampling_rate
  fields        = var.realtime_logging_config.fields

  endpoint {
    stream_type = "Kinesis"

    kinesis_stream_config {
      role_arn   = aws_iam_role.cloudfront_realtime_log_role[count.index].arn
      stream_arn = var.realtime_logging_config.kinesis_stream_arn
    }
  }
}
