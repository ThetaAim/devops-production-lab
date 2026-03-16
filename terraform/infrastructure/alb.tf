# --- ALB

resource "aws_lb" "app_alb" {
  count              = var.enable_alb ? 1 : 0
  name               = "devops-lab-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_public_sg.id]
  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  tags = {
    Name = "devops-lab-alb"
  }
}

# --- Target Group

resource "aws_lb_target_group" "app_tg" {

  count    = var.enable_alb ? 1 : 0
  name     = "devops-lab-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# --- Listener

resource "aws_lb_listener" "http_listener" {

  count             = var.enable_alb ? 1 : 0
  load_balancer_arn = aws_lb.app_alb[0].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg[0].arn
  }
}
