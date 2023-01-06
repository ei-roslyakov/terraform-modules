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

resource "aws_secretsmanager_secret" "secret" {
  count = var.create_pub_key_secret ? 1 : 0
  name = var.secret_name
}
 
 
resource "aws_secretsmanager_secret_version" "secret_v" {
  secret_id = aws_secretsmanager_secret.secret[0].id
  secret_string = try(var.secret_string, null)
  secret_binary = try(var.secret_binary, null)
}