data "aws_ami" "amazon_linux" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

## Subnet
data "aws_subnet" "app_public_subnet" {
  cidr_block  = "10.0.101.0/24"
}

data "aws_vpc" "vpc" {  
  filter {
    name   = "tag:Name"
    values = ["turma-08"]
  }
}

data "template_file" "ec2_mongodb" {
  template = file("${path.module}/scripts/mongodb.sh")
  vars = {
    version = var.mongodb_version    
  }
}

data "template_file" "ec2_app" {
  template = file("${path.module}/scripts/ec2.sh")
  vars = {
    version = lookup(var.ec2_app, "version")
    image   = lookup(var.ec2_app, "image")
    port    = lookup(var.ec2_app, "port")
    mongodb_server = aws_instance.mongodb_ec2.private_ip
  }
}