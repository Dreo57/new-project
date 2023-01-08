variable "webserver-subnet1" {

}
variable "webserver-subnet2" {
  
}
variable "webserver_sg" {

}
variable "webserver-target-group" {
  
}

variable "appserver-subnet1" {

}
variable "appserver-subnet2" {
  
}
variable "appserver_sg" {

}
variable "appserver-target-group" {
  
}

variable "instance_id" {
    default = "/Dreo/instance"  
}

variable "key_name" {
    default = "/Dreo/key"
}
locals {
  common_tags={
    Owner = "Devops Team"
    cs = "opeyd80@gmail.com"
   time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
#   prod_tags={
#     Owner = "Prod Team"
#     cs = "opeyd80@gmail.com"
#    time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())

#   }
#   dev_tags={
#     Owner = "dev Team"
#     cs = "opeyd80@gmail.com"
#    time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
#   }
}

# variable "name_tag" {
#   default = ["ventura-webserver", "ventura-appserver"]
# }