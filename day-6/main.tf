provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "this is ami"
}

variable "instance_type" {
  description = "this is the instance type. for ex : t2.large"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro") //here t2.micro is default if you not provide any workspace like dev, stage, prod
}