terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
  }
  backend "s3" {
    bucket = "jenkins-eks-bucket-01"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"

  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}
