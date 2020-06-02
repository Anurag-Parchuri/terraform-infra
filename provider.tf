provider "aws" {
    region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "yara-terraform-state"
    key    = "yara-terraform-state-poc/terraformstate.tf"
    region = "ap-south-1"
  }
}

