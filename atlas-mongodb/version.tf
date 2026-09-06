terraform {
  required_version = ">= 0.12"

  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "2.17.0"
    }
  }
}
