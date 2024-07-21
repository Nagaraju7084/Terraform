workspaces : it will create the different environment stage files at once.
ex. dev stage file, stage state file, prod state file

module will be invoked when we have terraform.tfvars

execution :
>terraform init
>terraform apply
ec2 instance will be created as per the provided variables
state file will getting created in root folder


to execute stage file :
>terraform apply -var-file=stage.tfvars
//it(terraform) is not adding the resource rather its changing the resource
//its not as expected the solution is create workspaces for each environment
//dev, stage, prod
>terraform workspaces new dev
>terraform workspaces new stage
>terraform workspaces new prod
//switching/moving one workspace to another workspace
>terraform workspace select dev
//to know the workspace you are in/current workspace(like git branch -> to know the current branch)
>terraform workspace show
