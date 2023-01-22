output "frontend-tg-arn" {
    value = aws_lb_target_group.webserver-tg.arn
}
output "frontend-lb-id" {
    value = aws_lb.frontend_alb.id
}
output "backend-tg-arn" {
    value = aws_lb_target_group.appserver-tg.arn
}
output "backend-lb-id" {
    value = aws_lb.backend_alb.id
}
output "backend-dns" {
    value = aws_lb.backend_alb.dns_name
}
output "frontend-dns" {
    value = aws_lb.frontend_alb.dns_name
}
output "frontend-zoneid" {
    value = aws_lb.frontend_alb.zone_id
  
}