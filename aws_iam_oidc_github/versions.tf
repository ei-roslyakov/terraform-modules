terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = "~> 1.0"
}
