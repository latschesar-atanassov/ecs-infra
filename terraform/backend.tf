terraform {
  backend "s3" {
    bucket         = "terraform-state-eu-central-1-971776360507"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-locks"
  }
}
