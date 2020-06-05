name                   = "yara-poc"
vpc_cidr               = "10.0.0.0/16"
public_subnet_numbers  = [1,2] 
private_subnet_numbers = [3,5]  
desired_size           = 3
max_size               = 5
instance_type          = ["m4.large"]