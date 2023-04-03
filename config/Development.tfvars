envirenment = "Development"
# terraform plan -var-file="config/Development.tfvars" from main folder
instance_type       = "t2.micro"
number_of_instances = 0
vpc_sub_id          = "sg-0c12dda18f1c97ddb"     #To be changed in each project
vpc_id              = "vpc-017451e372225c803"    #To be changed in each project
subnet_id           = "subnet-06b58b83e747cb9d1" #TO be changed in each project