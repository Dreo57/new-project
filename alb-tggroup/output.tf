output "target-gp-arn" {
    value = aws_lb_target_group.dre-tg.arn
}
output "elb-id" {
    value = aws_lb.dre_alb.id
}

# output "target-gp" {
#     value = aws_lb_target_group.dre-tg.id
# }
