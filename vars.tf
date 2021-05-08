variable "region" {
  default = "us-east-1"
}
variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "subnets_cidr" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "azs" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
}
variable "ami" {
  default = "ami-0742b4e673072066f"
}
variable "instance_type" {
  default = "t2.micro"
}
#locals {
#setup name = "BP"
#}


