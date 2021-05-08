provider "aws" {
  region = var.region
}
#backend "s3" {
#  bucket = "remote-state-tc" #bucket name
# key = "aws-devops/terraform.tfstate" #giving file directory or folder name where to store state file.
# region = "us-east-1"
#dynamodb_table = "remote-lock-tc" #name of the dynamodb which created.
#}