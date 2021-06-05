provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
  skip_credentials_validation = true
}


provider "template" {}


data "aws_ami" "my_image" {
  most_recent = true
  filter {
    name = "name"
    values = ["CENTOS*"]
  }

  owners = ["${var.ami_owner_id}"]

}

data "template_file" "init" {
  template = <<-EOF
        #!/bin/bash
        hostnamectl set-hostname "$${hostname}"
        EOF

  vars = {
    hostname = "${var.name_location}I${var.environment_tag}${var.name_app_type}${var.name_application}${var.number_start}"
  }
}

resource "aws_security_group" "test_sg" {
  description     = "more SG's"
  vpc_id          = "${var.vpc_id}"

  ingress {
    from_port   = "xxx1"
    to_port     = "xxx2"
    protocol    = "tcp"
    cidr_blocks = ["x.x.x.x/y"]
  }


  ingress {
    from_port   = "xxx3"
    to_port     = "xxx4"
    protocol    = "tcp"
    cidr_blocks = ["x.x.x.x/y"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    ResourcePOC = "${var.resource_POC}"
    Application = "${var.name_application}"
    Environment = "${var.environment_tag}"
    BillingCode = "${var.billing_code}"
    Name        = "${var.name_location}I${var.environment_tag}${var.name_app_type}${var.name_application}${var.number_start}"
  }
}

resource "aws_instance" "app" {
  ami                  = "${data.aws_ami.ice_os_image.id}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.key_name}"
  user_data            = "${data.template_file.init.rendered}"


  tags = {
    Portfolio   = "${var.portfolio}"
    ResourcePOC = "${var.resource_POC}"
    Application = "${var.name_application}"
    Environment = "${var.environment_tag}"
    BillingCode = "${var.billing_code}"
    Name        = "${var.name_location}I${var.environment_tag}${var.name_app_type}${var.name_application}${var.number_start}"
  }

  vpc_security_group_ids = ["${aws_security_group.test_sg.id}", "${var.default_sg}"]
  subnet_id              = "${var.subnet_id}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.root_volume_size}"
  }
}
