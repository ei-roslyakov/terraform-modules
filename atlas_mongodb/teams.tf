resource "mongodbatlas_team" "team" {
  for_each = var.teams

  org_id    = var.org_id
  name      = each.key
  usernames = each.value.users
}
