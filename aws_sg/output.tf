output "sg_name_with_id" {
  value       = { for sg in module.sg : sg.name => sg.id }
  description = "IDs on the AWS Security Groups associated with the instance."
}
