//define the aws provider configuration
provider "aws" {
  region = "us-east-1" //replace with your desired aws region
}

variable "cidr" {
  default = "10.0.0.0/16" //this cidr block for entire vpc
}

resource "aws_key_pair" "example" {
  key_name = "terraform_demo_naga" //replace with your desired key name
  public_key = file("~/.ssh/id_rsa.pub") //replace with the path to your public key file
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "sub1" { //this is not a public subnet
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"//this cidr block for subnet
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

//internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

//route table
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id
    //for the routable we have to attach internet gatway as our destination
  route {
      cidr_block = aws_internet_gateway.igw.id
  }
}

//associate the rout table with the subnet
resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

//security group
resource "aws_security_group" "webSg" {
  name = "web"
  vpc_id = aws_vpc.myvpc.id

  ingress {
      description = "HTTP from VPC"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
      description = "SSH"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
      Name = "Web-sg"
  }
}

resource "aws_instance" "server" {
  ami = "ami-abc123" //this is replaced with your desired aws instance ami
  instance_type = "t2.micro"
  key_name = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id = aws_subnet.sub1.id

  connection {
      type = "ssh"
      user = "ubuntu" //replace with the appropriate username for your ec2 instance
      private_key = file("~/.ssh/id_rsa") //replace with the path to your private key
      host = self.public_ip
  }

  //file provisioner to copy a file from local to the remote ec2 instance
  provisioner "file" {
      source = "app.py" //replace with the path to your local file
      destination = "/home/ubuntu/app.py" //replace with the path on the remote instance
  }
  provisioner "remote-exec" {
      inline = [
          "echo 'hello from the remote instance'",
          "sudo apt update -y", //update package lists (for ubuntu)
          "sudo apt-get install -y python3-pip", //example package installation 
          "cd /home/ubuntu",
          "sudo pip3 install flask",
          "sudo python3 app.py &",
      ]  
  }
}