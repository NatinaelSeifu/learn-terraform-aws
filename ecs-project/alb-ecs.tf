# User Facing Client Application Load Balancer
resource "aws_lb" "client_alb" {
  name        = "client-alb" 
  load_balancer_type = "application"
  security_groups    = var.sg-01
  subnets            = var.pub-subnets
  idle_timeout       = 60
  ip_address_type    = "dualstack"

  //tags = { "Name" = "${var.default_tags.project}-client-alb" }
}

# User Facing Client Target Group
resource "aws_lb_target_group" "client_alb_targets" {
  name          = "client-alb-tg"
  port                 = 3000
  protocol             = "HTTP"
  vpc_id               = "vpc-03636e12e8f0913d5"
  deregistration_delay = 30
  target_type          = "ip"

  health_check {
    enabled             = true
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 30
    interval            = 60
    protocol            = "HTTP"
  }

 // tags = { "Name" = "${var.default_tags.project}-client-tg" }
}

# User Facing Client ALB Listeners
resource "aws_lb_listener" "client_alb_http_80" {
  load_balancer_arn = aws_lb.client_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.client_alb_targets.arn
  }
}


############################################
# Server Side Application Load Balancer
############################################
resource "aws_lb" "server_alb" {
  name        = "server-alb" 
  load_balancer_type = "application"
  security_groups    = var.sg-01
  subnets            = var.pub-subnets
  idle_timeout       = 60
  ip_address_type    = "dualstack"

  //tags = { "Name" = "${var.default_tags.project}-client-alb" }
}

# Server Side ServerTarget Group
resource "aws_lb_target_group" "server_alb_targets" {
  name          = "sever-alb-tg"
  port                 = 5000
  protocol             = "HTTP"
  vpc_id               = "vpc-03636e12e8f0913d5"
  deregistration_delay = 30
  target_type          = "ip"

  health_check {
    enabled             = true
    path                = "/health"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 30
    interval            = 60
    protocol            = "HTTP"
  }

 // tags = { "Name" = "${var.default_tags.project}-client-tg" }
}

# Server Side ALB Listeners
resource "aws_lb_listener" "server_alb_http_80" {
  load_balancer_arn = aws_lb.server_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.server_alb_targets.arn
  }
}