resource "aws_security_group" "bastion_sg" {
  name        = var.bastion_name
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc
  dynamic "ingress" {
    for_each = [22, 80]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = var. cidr_blocks_id
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = var.cidr_blocks_id
  }
  tags = {
    Name = "Bastion Sec Grp"
  }
}

resource "aws_security_group" "frontend_lb_sg" {
  name        = var.frontend
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc
  dynamic "ingress" {
    for_each = [80]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = var.cidr_blocks_id
    }
  }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = var.cidr_blocks_id
  }
  tags = {
    Name = "Frontend-lb Sec Grp"
  }
}

resource "aws_security_group" "webserver_sg" {
  name        = var.webserver
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc
  dynamic "ingress" {
    for_each = [22, 80]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      security_groups  = [aws_security_group.frontend_lb_sg.id, aws_security_group.bastion_sg.id]
    }
  }
  egress {
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks = var.cidr_blocks_id
  }
  tags = {
    Name = "Webserver Sec Grp"
  }
}

resource "aws_security_group" "backend_lb_sg" {
  name        = var.backend
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc
  dynamic "ingress" {
    for_each = [80]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      security_groups  = [aws_security_group.webserver_sg.id]
      cidr_blocks = var.cidr_blocks_id
    }
  }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = var.cidr_blocks_id
  }
  tags = {
    Name = "Backend-lb Sec Grp"
  }
}

resource "aws_security_group" "appserver_sg" {
  name        = var.appserver
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc
  dynamic "ingress" {
    for_each = [22, 80]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      security_groups  = [aws_security_group.backend_lb_sg.id, aws_security_group.bastion_sg.id]
    }
  }
  egress {
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks = var.cidr_blocks_id
  }
  tags = {
    Name = "Appserver Sec Grp"
  }
}

resource "aws_security_group" "rds_db_sg" {
  name        = var.database
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc
  dynamic "ingress" {
    for_each = [3306]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      security_groups  = [aws_security_group.appserver_sg.id, aws_security_group.bastion_sg.id]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = var.cidr_blocks_id
  }
  tags = {
    Name = "RDS Sec Grp"
  }
}
