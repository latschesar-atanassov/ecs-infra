resource "aws_lb" "public" {
  name               = "ecs-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_alb.id]
  subnets = [
    aws_subnet.public_snet_a.id,
    aws_subnet.public_snet_b.id,
    aws_subnet.public_snet_c.id
  ]

  enable_deletion_protection = false
}

resource "aws_lb" "private" {
  name               = "ecs-private-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.private_alb.id]
  subnets = [
    aws_subnet.private_snet_alb_a.id,
    aws_subnet.private_snet_alb_b.id,
    aws_subnet.private_snet_alb_c.id
  ]

  enable_deletion_protection = false
}

resource "aws_alb_target_group" "main" {
  name        = "ecs-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "private_http_redirect" {
  load_balancer_arn = aws_lb.private.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "public_http_redirect" {
  load_balancer_arn = aws_lb.public.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# resource "aws_alb_listener" "https" {
#   load_balancer_arn = aws_lb.main.id
#   port              = 443
#   protocol          = "HTTPS"

#   ssl_policy        = "ELBSecurityPolicy-2016-08"

#   default_action {
#     target_group_arn = aws_alb_target_group.main.id
#     type             = "forward"
#   }
# }
