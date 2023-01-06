variable "bastion_name" {
    default = "Bastion-Host-Security-Group"  
}

variable "frontend" {
    default = "Frontend-LB-Security-Group"  
}

variable "backend" {
    default = "Backend-LB-Security-Group"  
}

variable "webserver" {
    default = "Webservers-Security-Group"  
}

variable "appserver" {
    default = "Appservers-Security-Group"  
}

variable "database" {
    default = "Database-Security-Group"  
}



variable "cidr_blocks_id" {
    default = ["0.0.0.0/0"]

}

variable "vpc" {
  
}
# variable "sg_name2" {
#     default = "dreo-ec2_sg"
  
# }

variable "sg_name3" {
    default = "dreo-lb_sg"
  
}
