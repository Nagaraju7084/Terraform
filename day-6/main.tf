provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "this is ami"
}

variable "instance_type" {
  description = "this is the instance type. for ex : t2.large"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = var.instance_type
}