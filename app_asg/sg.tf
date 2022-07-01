resource "aws_security_group" "allow_mongodb" {
  name        = format("%s-allow-mongodb-%s", var.project, var.env)
  description = "Allow ssh and http inbound traffic"
  vpc_id      = data.aws_vpc.vpc.id

  ingress = [
    {
      description      = "Allow MongoDB"
      from_port        = 27017
      to_port          = 27017
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = null
    }
  ]
  egress = [
    {
      description      = "Allow all"
      from_port        = "0"
      to_port          = "0"
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = null
    }
  ]

  tags = {
    "Name" = format("%s-allow_mongodb-%s", var.project, var.env)
  }
}

resource "aws_network_interface_sg_attachment" "mongodb_sg_attach" {
  security_group_id    = aws_security_group.allow_mongodb.id
  network_interface_id = aws_instance.mongodb.primary_network_interface_id
}

resource "aws_security_group" "allow_ssh_http" {
  name        = format("%s-allow_http_ssh-%s", var.project, var.env)
  description = "Allow ssh and http inbound traffic"
  vpc_id      = data.aws_vpc.vpc.id

  ingress = [
    {
      description      = "Allow SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = null

    },
    {
      description      = "Allow HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = null
    }
  ]

  egress = [
    {
      description      = "Allow all"
      from_port        = "0"
      to_port          = "0"
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = null
    }
  ]
  tags = {
    "Name" = format("%s-allow_http_ssh-%s", var.project, var.env)
  }
}