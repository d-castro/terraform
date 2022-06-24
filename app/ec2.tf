resource "aws_instance" "app_ec2" {
  ami                           = data.aws_ami.amazon_linux.id
  instance_type                 = lookup(var.instance_type_app, local.env)
  subnet_id                     = data.aws_subnet.app_public_subnet.id
  associate_public_ip_address   = true
  key_name                      = aws_key_pair.app_key.id
  user_data                     = file("scripts/ec2.sh") 

  tags = {
    Name = format("%s-app", local.name)
    }
}

resource "aws_instance" "mongodb_ec2" {
  ami                           = data.aws_ami.amazon_linux.id
  instance_type                 = var.instance_type_mongodb
  subnet_id                     = data.aws_subnet.app_public_subnet.id
  associate_public_ip_address   = true
  key_name                      = aws_key_pair.app_key.id
  user_data                     = file("scripts/mongodb.sh") 

  tags = {
    Name = format("%s-mongodb", local.name)
  }
}

resource "aws_key_pair" "app_key" {
  key_name   = format("key-%s", local.name)
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkORqeis2X20TVm0kZgI5jfKHt96oc0XKVO9PrBmKDbz4y4wgaEK/OrgzDy/kYgDpyD3Unbh4DOtUZ1+RjomE0jvnXYKD8ciGvL6+sF/jHsoeYlhNo6Iks9aV0TmjXeXPvqpxA1qm40b4gqb4hHBIgnDbdXdSgsC//2kapkCH/lNsS6s83n97UL8WFmBKmUMM2F5OGWfmHFltS0hW0ml4E/MFeeHHLLJHxugbiUSJ8O1d4K8nCL+r+uja+tW8UetcZc5Q7m5M/MjFjETyCaTa9eaXpj44ddSbCwFHS0YtXqhSzILofoT/n9FAfSHNk2H5WbrADY7FwS8VMwfaFC1MGxfnnvSesGpVE8yhLVzJPdrROYehjUY29NAaAw5z4Uto+t3mObUXPIsCIOiUSLQnR9UmGrquL7/N85TLyGMKakSAckhuy3l6UWP1x696opOGjNJJvZw0f89rBoWXUO6zYafJBZPneVraF4cYdWQNFHi0dJVNlIkAZoZ9B3g6uwxc= app-turma08"
}