output "id_ami"{
 value = data.aws_ami.amazon_linux
}

output "mongodb_ec2_private_ip"{
 value = aws_instance.mongodb_ec2.private_ip
}

output "app_public_ip" {
  value = aws_instance.app_ec2[*].public_ip
}