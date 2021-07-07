terraform {
  backend "s3" {
    bucket  = "my-bucket-name"
    key     = "dev/dev-tfstate"
    region  = "us-east-1"
    
  }
}


# modules
module "dev1" {
  source = "../ec2-app"

  root_volume_size = "200"
  number_start     = "001"
}

module "dev2" {
  source = "../ec2-app"

  root_volume_size = "500"
  number_start     = "002"
}

module "dev3" {
  source = "../ec2-app"

  root_volume_size = "300"
  number_start     = "003"
}