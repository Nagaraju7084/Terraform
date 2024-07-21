provider "aws" {
  region = "us-east-1"
}

import{
    id = "i-0abc123" //replace this value with the actual aws instance id

    to = aws_instance.example
}