terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0"
    }
  }

  backend "s3" {
    bucket = "ekart-terraform-remote-backend-s3"
    key    = "dev/terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}