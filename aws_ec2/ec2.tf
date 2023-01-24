locals {
  instance_count    = var.instance_enabled ? 1 : 0
  availability_zone = var.availability_zone != "" ? var.availability_zone : data.aws_subnet.default.availability_zone
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_subnet" "default" {
  id = var.subnet_id
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_instance_profile" "default" {
  count = var.iam_instance_profile == "" ? 1 : 0
  name  = "${var.name}-role"
  role  = join("", aws_iam_role.default.*.name)
}

resource "aws_iam_role" "default" {
  count              = var.iam_instance_profile == "" ? 1 : 0
  name               = "${var.name}-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.default.json
}

resource "aws_instance" "default" {
  count                                = local.instance_count
  ami                                  = try(var.ami, data.aws_ami.ubuntu.id)
  instance_type                        = var.instance_type
  user_data                            = var.user_data
  key_name                             = var.ssh_key_pair
  monitoring                           = var.monitoring
  iam_instance_profile                 = try(var.iam_instance_profile, join("", aws_iam_instance_profile.default.*.name))
  associate_public_ip_address          = var.associate_public_ip_address
  subnet_id                            = var.subnet_id
  private_ip                           = var.private_ip
  ipv6_address_count                   = var.ipv6_address_count
  ipv6_addresses                       = var.ipv6_addresses
  ebs_optimized                        = var.ebs_optimized
  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior

  vpc_security_group_ids = var.vpc_security_group_ids

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}
resource "aws_eip" "default" {
  count             = var.associate_public_ip_address && var.assign_eip_address && var.instance_enabled ? 1 : 0
  network_interface = join("", aws_instance.default.*.primary_network_interface_id)
  vpc               = true
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}
