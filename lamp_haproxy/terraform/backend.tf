terraform {
  backend "s3" {
    bucket = "arctiq-tim-tf-state"
    key    = "arctiq-demo"
    region = "us-east-1"
  }
}
