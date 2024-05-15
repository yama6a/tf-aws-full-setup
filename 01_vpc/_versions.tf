terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "pontiki-tfstate-sandbox"
    key    = "tfstate/0001_vpc.tfstate"
    region = "eu-west-1"
  }
}
