variable "aws_region" { 
    default = "us-east-1" 
}
variable "aws_profile" { 
    default = "default" 
}
variable "ami_owner_id" { 
    default = "xxxxxxx" 
}
variable "instance_type" { 
    default = "t2.medium" 
}
variable "vpc_id" { 
    default = "vpc-xxxxxx" 
}
variable "subnet_id" { 
    default = "subnet-xxxxx" 
}
variable "default_sg" { 
    default = "sg-xxxxxx" 
}
variable "environment_tag" { 
    default = "DV" 
}
variable "resource_POC" { 
    default = "teegobezie@gmail.com"
}
variable "name_location" { 
    default = "W1" 
}
variable "name_application" { 
    default = "ANS" 
}
variable "name_app_type" { 
    default = "TST" 
}
variable "key_name" { 
    default = "mykey" 
}
variable "root_volume_size" {}
variable "number_start" {}
