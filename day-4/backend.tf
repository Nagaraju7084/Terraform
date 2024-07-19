terraform{
    backend "s3" {
        bucket = "mybucket"
        region = "us-east-1"
        key = "naga/terraform.tsstate" //actual key
    }
}

//first s3 bucket should create, later this file will  be use