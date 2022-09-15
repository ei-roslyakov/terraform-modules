output "role_name_with_arn" {
  description = "The name of the IAM role created"
  value = {
    for role in module.role : role.name => role.arn
  }
}

output "role_name_with_id" {
  description = "The stable and unique string identifying the role"
  value = {
    for role in module.role : role.name => role.id
  }
}

output "policy" {
  description = "Role policy document in json format. Outputs always, independent of `enabled` variable"
  value = {
    for role in module.role : role.name => role.policy
  }
}
