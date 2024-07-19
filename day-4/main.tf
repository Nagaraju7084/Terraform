//without using remote backend
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "naga" {
  instance_type = "t2.micro"
  ami = "abc123" //this is not actual aws ami, we have to provide actual aws ami here
  subnet_id = "subnet-123" //this is not actual subnet id, we have to provide actual aws subnet id here
}

//execute this file using 1.terraform init 2.terraform plan(optional) 3.terraform apply
//then you will get the state file in the project folder
//delete the state file

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "naga-s3-xyz"
}