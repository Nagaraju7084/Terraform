topic : most asked interview scenarios
scenario-1 : terraform migration
scenario-2 : 

//after writing the file, execute
>terraform init
//next execute
>terraform plan -generate-config-out=generated_resources.tf

//another way to import
>terraform import aws_instance.example i-0abc123 =>this is right way to import instance information
//aws_instance.example => instance with the name
//i-0abc123 => instance id(replace with actual aws instance id)
//to refresh the state file
//terraform refresh