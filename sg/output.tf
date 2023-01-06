output "bastion_sg" {
    value = aws_security_group.bastion_sg.id
}
output "frontend_lb_sg" {
    value = aws_security_group.frontend_lb_sg.id
}
output "webserver_sg" {
    value = aws_security_group.webserver_sg.id
}
output "backend_lb_sg" {
    value = aws_security_group.backend_lb_sg.id
}
output "appserver_sg" {
    value = aws_security_group.appserver_sg.id
}
output "rds_db_sg" {
    value = aws_security_group.rds_db_sg.id
}
