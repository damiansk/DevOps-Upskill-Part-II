terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "dstolarek-upskill-devops-terraform-apps-s3-state"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dstolarek-terraform-apps-s3-dynamodb"
    encrypt        = true
    profile        = "dstolarek-upskill-devops"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "dstolarek-upskill-devops"
}
