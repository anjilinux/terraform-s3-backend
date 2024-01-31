
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "test-visa-hp"
    key            = "terraform.tfstate"
    region         = "us-east-1"

   }
  }
