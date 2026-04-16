resource "aws_eip" "eip" {
  count = var.count_eip > 0 ? var.count_eip : 0

  vpc = true

  instance          = try(var.instance, "")
  network_interface = try(var.network_interface, "")

  tags = merge(
    {
      "Name" = "${var.name}-${count.index + 1}"
    },
    var.tags,
  )
}