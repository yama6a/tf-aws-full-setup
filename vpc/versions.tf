terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "pontiki-tfstate-sandbox"
    key    = "tfstate/terraform.tfstate"
    region = "eu-west-1"
  }

  required_version = "~> 1.0"
}
