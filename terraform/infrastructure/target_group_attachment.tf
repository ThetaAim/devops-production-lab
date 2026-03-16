resource "aws_lb_target_group_attachment" "attach_ec2" {
  count            = var.enable_alb ? length(aws_instance.ec2_micro_ecr) : 0
  target_group_arn = aws_lb_target_group.app_tg[0].arn
  target_id        = aws_instance.ec2_micro_ecr[count.index].id
  port             = 80
}

