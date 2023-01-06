output "vpc_id" {
    value = aws_vpc.projvpc.id
}

output "nat-al-subnet1" {
    value = aws_subnet.nat-al-subnet[0].id
}

output "nat-al-subnet2" {
    value = aws_subnet.nat-al-subnet[1].id
}

output "prod-webserver-subnet1" {
    value = aws_subnet.prod-webserver-subnet[0].id
}
output "prod-webserver-subnet2" {
    value = aws_subnet.prod-webserver-subnet[1].id
}

output "prod-appserver-subnet1" {
    value = aws_subnet.prod-appserver-subnet[0].id
}
output "prod-appserver-subnet2" {
    value = aws_subnet.prod-appserver-subnet[1].id
}

output "database-subnet1" {
    value = aws_subnet.database-subnet[0].id
}
output "database-subnet2" {
    value = aws_subnet.database-subnet[1].id
}

# output "route-table-id" {
#     value = aws_route_table.projpubrt[0].id
# }
# output "route-table-id1" {
#     value = aws_route_table.projpubrt[1].id
# }

output "nat-al-subnet-az1" {
    value = aws_subnet.nat-al-subnet[0].availability_zone
}
output "nat-al-subnet-az2" {
    value = aws_subnet.nat-al-subnet[1].availability_zone
}

output "prod-webserver-subnet-az1" {
    value = aws_subnet.prod-webserver-subnet[0].availability_zone
}
output "prod-webserver-subnet-az2" {
    value = aws_subnet.prod-webserver-subnet[1].availability_zone
}

output "prod-appserver-subnet-az1" {
    value = aws_subnet.prod-appserver-subnet[0].availability_zone
}
output "prod-appserver-subnet-az2" {
    value = aws_subnet.prod-appserver-subnet[1].availability_zone
}
output "database-subnet-az1" {
    value = aws_subnet.database-subnet[0].availability_zone
}
output "database-subnet-az2" {
    value = aws_subnet.database-subnet[1].availability_zone
}