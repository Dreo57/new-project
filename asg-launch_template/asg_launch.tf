data "aws_ssm_parameter" "key_parameter" {
  name = var.key_name
}

data "aws_ssm_parameter" "instance_parameter" {
  name = var.instance_id
}

data "aws_iam_role" "dreo_role" {
  name = "AWS-SSMFull"  
}

resource "aws_iam_instance_profile" "dreo_profile" {
  name = "dreo_inst_profile"  
  role = data.aws_iam_role.dreo_role.id
}

data "aws_ami" "web_server_ami" {
  most_recent = true
  owners = ["099720109477"] #canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

    filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_launch_template" "webserver_temp" {
  name = "ventura-webserver-template"
  description = "webserver launch template for ASG"
  image_id = data.aws_ami.web_server_ami.id
  instance_type= data.aws_ssm_parameter.instance_parameter.value
  key_name= data.aws_ssm_parameter.key_parameter.value
  vpc_security_group_ids =  [var.webserver_sg]
  iam_instance_profile {
    name = aws_iam_instance_profile.dreo_profile.id
  }
  tags = merge(local.common_tags,{Name = "ventura-webserver"})

  user_data = "${base64encode(file("web-server-proxy-setup.sh"))}"

}

resource "aws_autoscaling_group" "ventura-webserver-asg" {
  name_prefix = "ventura-webserver-asg"
  depends_on = [aws_launch_template.webserver_temp]
  launch_template  {
    id = aws_launch_template.webserver_temp.id
    version = "$Latest"
  }
  vpc_zone_identifier = [var.webserver-subnet1, var.webserver-subnet2]
  target_group_arns = [var.webserver-target-group]
  health_check_type = "EC2"
  health_check_grace_period = 300
  desired_capacity= 2
  max_size = 4
  min_size = 2
  tag {
    key = "Name"
    value = "ventura-webserver"
    propagate_at_launch = true
  }

}

data "aws_ami" "app_server_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

}

resource "aws_launch_template" "appserver_temp" {
  name = "ventura-appserver-template"
  description = "appserver launch template for ASG"
  image_id = data.aws_ami.app_server_ami.id
  instance_type= data.aws_ssm_parameter.instance_parameter.value
  key_name= data.aws_ssm_parameter.key_parameter.value
  vpc_security_group_ids =  [var.appserver_sg]
  iam_instance_profile {
    name = aws_iam_instance_profile.dreo_profile.id
  }
  tags = merge(local.common_tags,{Name = "ventura-appserver"})

  user_data = "${base64encode(file("app-server-proxy-setup.sh"))}"

}

resource "aws_autoscaling_group" "ventura-appserver-asg" {
  name_prefix = "ventura-appserver-asg"
  depends_on = [aws_launch_template.appserver_temp]
  launch_template  {
    id = aws_launch_template.appserver_temp.id
    version = "$Latest"
  }
  vpc_zone_identifier = [var.appserver-subnet1, var.appserver-subnet2]
  target_group_arns = [var.appserver-target-group]
  health_check_type = "EC2"
  health_check_grace_period = 300
  desired_capacity= 2
  max_size = 4
  min_size = 2
  tag {
  key = "Name"
  value = "ventura-appserver"
  propagate_at_launch = true
  }

}



