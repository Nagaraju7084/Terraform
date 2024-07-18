provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance" //we have to tell terraform where it has to fetch the module from or location of the module
  ami_value ="abc123"
  instance_type_value = "t2.micro"
  subnet_id_value = "abc456"
}

//location of the module if module is in github repository then provide that github link/url
//we can call the modules and pass the values using main.tf