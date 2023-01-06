variable "nat-al-subnet" {
    default = ["45.0.1.0/24","45.0.3.0/24"]
      
}

variable "prod-webserver-subnet" {
    default = ["45.0.2.0/24","45.0.4.0/24"]
      
}

variable "prod-appserver-subnet" {
    default = ["45.0.10.0/24", "45.0.12.0/24"]
      
}

variable "database-subnet" {
    default = ["45.0.30.0/24", "45.0.50.0/24"]
      
}


variable "availability_zone_pub" {
    default = ["us-east-1a","us-east-1b"]
    # default = ["us-west-2a", "us-west-2a","us-west-2b", "us-west-2b"]  
}

variable "availability_zone_prvt" {
    default = ["us-east-1a","us-east-1b"]
    # default = ["us-west-2a", "us-west-2a","us-west-2b", "us-west-2b"]  
}


variable "sn_name_tag_pub" {
  default = ["Prod-NAT-ALB-Subnet-1", "Prod-NAT-ALB-Subnet-2"]
}

variable "sn_web_tag_prvt" {
  default = ["Prod-Webserver-Subnet-1" , "Prod-Webserver-Subnet-2"]
}

variable "sn_app_tag_prvt" {
  default = ["Prod-Appserver-Subnet-1" , "Prod-Appserver-Subnet-2"]
}

variable "sn_db_tag_prvt" {
  default = ["Database-Subnet-1" , "Database-Subnet-2"]
}


variable "route-table-tag" {
  default = ["natrt1", "natrt2", "webrt1", "webrt2", "apprt1", "apprt2", "dbrt1", "dbrt2"]
  
}

# variable "nat-gateway-tag" {
#   default = ["vent-prod-rt", "vent-prod-rt1"]
  
# }

