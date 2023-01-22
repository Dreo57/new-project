data "aws_route53_zone" "ventura_zone" {
    name = "dreoconsulting.com"
    private_zone = false  
}

resource "aws_route53_record" "ventura_record" {
    zone_id = data.aws_route53_zone.ventura_zone.id
    name = "${data.aws_route53_zone.ventura_zone.name}"
    type = "A"
    alias{
        name = var.frontend_lb_dns
        zone_id = var.frontend_lb_zoneid
        evaluate_target_health = false
    }  
}

