output "mongodbatlas_cluster_ids" {
  description = "IDs of the MongoDB Atlas clusters."
  value = {
    for k, cluster in mongodbatlas_cluster.cluster :
    try(cluster.name, k) => cluster.id
  }
}

output "mongodbatlas_cluster_mongo_uri" {
  description = "IDs of the MongoDB Atlas clusters."
  value = {
    for k, cluster in mongodbatlas_cluster.cluster :
    try(cluster.name, k) => cluster.mongo_uri
  }
}

output "mongodbatlas_cluster_connection_strings" {
  description = "IDs of the MongoDB Atlas clusters."
  value = {
    for k, cluster in mongodbatlas_cluster.cluster :
    try(cluster.name, k) => cluster.connection_strings
  }
}

output "mongodbatlas_cluster_srv_address" {
  description = "IDs of the MongoDB Atlas clusters."
  value = {
    for k, cluster in mongodbatlas_cluster.cluster :
    try(cluster.name, k) => cluster.srv_address
  }
}

output "mongodbatlas_cluster_snapshot_backup_policy" {
  description = "IDs of the MongoDB Atlas clusters."
  value = {
    for k, cluster in mongodbatlas_cluster.cluster :
    try(cluster.name, k) => cluster.snapshot_backup_policy
  }
}

output "mongodbatlas_project_ids" {
  description = "IDs of the MongoDB Atlas projects."
  value = {
    for k, project in mongodbatlas_project.project :
    try(project.name, k) => project.id
  }
}

output "mongodbatlas_team_ids" {
  description = "IDs of the MongoDB Atlas teams."
  value = {
    for k, team in mongodbatlas_team.team :
    try(team.name, k) => team.id
  }
}
