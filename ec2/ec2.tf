resource "aws_instance" "bastion-host" {
  ami           = data.aws_ami.bastion_ami.id
  instance_type = data.aws_ssm_parameter.instance_parameter.value
  associate_public_ip_address   = true
  subnet_id = var.nat-al-subnet
  vpc_security_group_ids =  [var.bastion_sg]
  iam_instance_profile = data.aws_iam_role.dreo_role.id
  key_name = data.aws_ssm_parameter.key_parameter.value  
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    }

  tags = {
    Name = "bastion-host-jump-box"
  }

  user_data = "${base64encode(file("script.sh"))}"

}

data "aws_ssm_parameter" "key_parameter" {
  name = var.key_name
}

data "aws_ssm_parameter" "instance_parameter" {
  name = var.instance_id
}

data "aws_iam_role" "dreo_role" {
  name = "AWS-SSMFull"
}

data "aws_ami" "bastion_ami" {
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
