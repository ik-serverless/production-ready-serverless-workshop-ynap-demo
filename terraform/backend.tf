terraform {
  backend "s3" {
    bucket="ynap-production-ready-serverless-yancui"
    key="terraform.tfstate"
    region="us-east-1"
  }
}