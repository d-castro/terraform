resource "aws_security_group" "allow_ssh_http" {
  name        = format("%s-allow-http-ssh", local.name)
  description = "Allow ssh and http inbound traffic"
  vpc_id      = data.aws_vpc.vpc.id

  ingress = [
    {
        description      = "ssh from VPC"
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
        description      = "ssh from VPC"
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
}

resource "aws_security_group" "allow_ssh_mongodb" {
  name        = format("%s-allow-mongodb", local.name)
  description = "Allow ssh and http inbound traffic"
  vpc_id      = "vpc-0448c0bcf55aa547d"

  ingress = [
    {
        description      = "mondb port from VPC"
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
}

resource "aws_network_interface_sg_attachment" "sg_attachment_app" {
  security_group_id    = aws_security_group.allow_ssh_http.id
  network_interface_id = aws_instance.app_ec2.primary_network_interface_id
}

resource "aws_network_interface_sg_attachment" "sg_attachment_mongo_db" {
  security_group_id    = aws_security_group.allow_ssh_mongodb.id
  network_interface_id = aws_instance.mongodb_ec2.primary_network_interface_id
}