resource "aws_lb" "frontend_alb" {
    name = "frontend-alb"
    internal = false
    load_balancer_type = "application"  
    security_groups    = [var.frontend-sg_id]
    subnets            = [var.nat-al-subnet1, var.nat-al-subnet2]  
}

resource "aws_lb_listener" "frontend-listener" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver-tg.arn
  }
}

resource "aws_lb_target_group" "webserver-tg" {
    name = "webserver-target-group"
    # target_type = "ip"
    target_type = "instance"
    protocol = "HTTP"
    port = 80
    vpc_id = var.vpc
    health_check {
      protocol = "HTTP"
      path = "/VenturaMailingApp.php"
      port = 80
    }
  
}

resource "aws_lb" "backend_alb" {
    name = "backend-alb"
    internal = false
    load_balancer_type = "application"  
    security_groups    = [var.backend-sg_id]
    subnets            = [var.webserver-subnet1, var.webserver-subnet2]  
}

resource "aws_lb_listener" "backend-listener" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.appserver-tg.arn
  }
}

resource "aws_lb_target_group" "appserver-tg" {
    name = "appserver-target-group"
    # target_type = "ip"
    target_type = "instance"
    protocol = "HTTP"
    port = 80
    vpc_id = var.vpc
    health_check {
      protocol = "HTTP"
      path = "/VenturaMailingApp.php"
      port = 80
    }
  
}

