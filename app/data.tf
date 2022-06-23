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