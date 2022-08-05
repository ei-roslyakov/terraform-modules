resource "aws_globalaccelerator_accelerator" "this" {
  count           = var.create_globalaccelerator_accelerator ? 1 : 0
  name            = var.name
  ip_address_type = "IPV4"
  enabled         = true

  attributes {
    flow_logs_enabled   = var.flow_logs_enabled
    flow_logs_s3_bucket = var.flow_logs_s3_bucket
    flow_logs_s3_prefix = var.flow_logs_s3_prefix
  }

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )
}

resource "aws_globalaccelerator_listener" "http" {
  count           = var.create_elb_listener ? 1 : 0
  accelerator_arn = join("", aws_globalaccelerator_accelerator.this.*.id)
  client_affinity = "NONE"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}

resource "aws_globalaccelerator_listener" "https" {
  count           = var.create_elb_listener ? 1 : 0
  accelerator_arn = join("", aws_globalaccelerator_accelerator.this.*.id)
  client_affinity = "NONE"
  protocol        = "TCP"

  port_range {
    from_port = 443
    to_port   = 443
  }
}

resource "aws_globalaccelerator_endpoint_group" "http" {
  count                 = var.create_elb_listener ? 1 : 0
  listener_arn          = join("", aws_globalaccelerator_listener.http.*.id)
  health_check_protocol = "TCP"
  health_check_port     = 80
  endpoint_group_region = var.endpoint_group_region

  dynamic "endpoint_configuration" {
    for_each = local.endpoint_configurations

    content {
      client_ip_preservation_enabled = try(endpoint_configuration.value.client_ip_preservation_enabled, null)
      endpoint_id                    = try(endpoint_configuration.value.endpoint_id, null)
      weight                         = try(endpoint_configuration.value.weight, null)
    }
  }


  lifecycle {
    ignore_changes = [
      health_check_path,
    ]
  }
}

resource "aws_globalaccelerator_endpoint_group" "https" {
  count                 = var.create_elb_listener ? 1 : 0
  listener_arn          = join("", aws_globalaccelerator_listener.https.*.id)
  health_check_protocol = "TCP"
  health_check_port     = 443
  endpoint_group_region = var.endpoint_group_region
  dynamic "endpoint_configuration" {
    for_each = local.endpoint_configurations

    content {
      client_ip_preservation_enabled = try(endpoint_configuration.value.client_ip_preservation_enabled, null)
      endpoint_id                    = try(endpoint_configuration.value.endpoint_id, null)
      weight                         = try(endpoint_configuration.value.weight, null)
    }
  }

  lifecycle {
    ignore_changes = [
      health_check_path,
    ]
  }
}
