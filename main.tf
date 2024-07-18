variable "ami_value" {
  description = "value for the ami"
}
variable "instance_type" {
  description = "value for the instance type"
}
variable "subnet_id" {
  description = "value for the subnet id"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = ""
  instance_type = ""
  subnet_id = ""
}