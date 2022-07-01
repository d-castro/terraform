resource "aws_alb" "app_alb" {
  name               = format("%s-app-lb-%s", var.project, var.env)
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_ssh_http.id]
  subnets            = [data.aws_subnet.app_subnet.id, data.aws_subnet.app_subnet2.id]
}

resource "aws_alb_listener" "app_lb_listener" {
  load_balancer_arn = aws_alb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = format("%s-app-tg-%s", var.project, var.env)
  port     = "80"
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc.id
  health_check {
    path     = "/healthcheck"
    port     = "80"
    protocol = "HTTP"
    interval = "10"
    timeout  = "5"
  }
}