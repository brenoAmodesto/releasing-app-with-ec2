terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.49.0"
    }
  }
    backend "s3" {
      bucket = "bucket-dj-app"
      key = "djapp"  
      region = "sa-east-1"
  }   
}

provider "aws" {
  region = "sa-east-1"
}
