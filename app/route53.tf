resource "aws_route53_zone" "app_zone" {
  name = format("%s.com.br", var.project)
  vpc {
    vpc_id = data.aws_vpc.vpc.id
  }
}

resource "aws_route53_record" "mongodb" {
  zone_id = aws_route53_zone.app_zone.zone_id
  name    = format("mongodb.%s.com.br", var.project)
  type    = "A"
  ttl     = "300"
  records = [aws_instance.mongodb_ec2.private_ip]
}