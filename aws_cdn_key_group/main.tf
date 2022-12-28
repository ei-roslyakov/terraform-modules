resource "aws_cloudfront_public_key" "key" {
  comment     = var.public_key_comment
  encoded_key = file(var.pub_key_file)
  name        = var.public_key_name
}

resource "aws_cloudfront_key_group" "key_group" {
  comment = var.key_group_comment
  items   = [aws_cloudfront_public_key.key.id]
  name    = var.key_group_name
}