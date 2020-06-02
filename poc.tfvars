name                   = "yara-poc"
vpc_cidr               = "10.0.0.0/16"
public_subnet_numbers  = [1,2] 
private_subnet_numbers = [3,5]  
az                     = ["ap-south-1a","ap-south-1b"]
desired_size           = 3
max_size               = 5
instance_type          = "m4.large"