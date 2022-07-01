resource "aws_instance" "mongodb" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  subnet_id                   = data.aws_subnet.app_subnet.id
  associate_public_ip_address = false
  key_name                    = aws_key_pair.app_ssh_key.id
  user_data                   = data.template_file.mongodb_startup_script.rendered

  tags = {
    Name = format("%s-mongodb_server-%s", var.project, var.env)
  }
}

resource "aws_key_pair" "app_ssh_key" {
  key_name   = format("%s-ssh-%s", var.project, var.env)
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDpS3V2rtyfFxzQ+7bMlZWzbaklDcsn+i4NGPMPgUqnFu5w9nz+gzDE/8jYE9AJa4xVtsakxO8AUJQzYCxzTH+na9Cv57v+FhP+uN/9kKzvggmgAcAdHeoMS9XNZe3ZM41xtDgtaltILhg/0xdeHa7ZmhDoKjNm1r+a8Z27mq62BawgYNrMnukLaM4K2kqDrGw3mcDI3bLDjFvTfXjZ5eI0j8VV9e5k+3a8ISDUBXr7BmXb1gHVZdM25P7aHh7Fu6bPIntVJIYLpPJaXzBL9SLk2UTc24dlaKjZmHwta7d3YWZWA1HWHYiDnz5ipOtcOwNAlHPMSKdGKbP8MyO9DMgISuJEL8jJI0jniePb60QwldWFPQFpN3bBJVS23OPcC6ZI7HiuT3dhauMAmKXOgQgRoawovlMM4frYWa52T1wDQu0GqLWXd6GBl+COb/9XFZ8uOd3t8DyhyzwPG9EspF9swled7RXRadCCQLAh8TxNrb28Edqlzc8hKXwbGKhlS4k= appkey"
}