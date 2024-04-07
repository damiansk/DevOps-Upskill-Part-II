terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "dstolarek-upskill-devops-terraform-apps-s3-state" // Use same as infra
    key            = "state/terraform.tfstate"                          // Change key to have different than in infra
    region         = "us-east-1"
    dynamodb_table = "dstolarek-terraform-apps-s3-dynamodb" // Use same as infra
    encrypt        = true
    profile        = "dstolarek-upskill-devops"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "dstolarek-upskill-devops"
}

# provider "aws" {
#   region = var.region
#   default_tags {
#     tags = var.tags # Use deafult tags - will be passed to all resources
#   }
# }
