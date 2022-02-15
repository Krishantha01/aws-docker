 locals {   
    today_date = formatdate("YYYY-MM-DD",timestamp())
    min = 0
    max = 1
  }

resource "aws_lb" "this" {
  name               = "flask-app-tf"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_target_group" "this" {
  name     = "flask-app-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}


resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group_attachment" "this" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_lb.this.arn
  port             = 80
}

resource "aws_launch_configuration" "this" {
  name          = "web_config"
  image_id      = var.image_id
  instance_type = "t2.micro"
  user_data = <<EOF
		#! /bin/bash
        docker create -it --name flask-app -p 8080:80 257997452906.dkr.ecr.us-east-1.amazonaws.com/flask-app:01
	EOF
}

resource "aws_autoscaling_group" "this" {
  name                      = "flask-app-tf"
  max_size                  = 1
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.this.name
  vpc_zone_identifier       = var.subnet_ids
}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = aws_autoscaling_group.this.id
  elb                    = aws_lb.this.id
}

resource "aws_autoscaling_schedule" "off" {
     scheduled_action_name  = "off_instance"
     min_size               = local.min
     max_size               = local.max
     desired_capacity       = 0
     start_time             =  "${local.today_date}T08:30:00Z" 
     recurrence             = "30 ${var.hour_to_switch_off} * * *"
     autoscaling_group_name = aws_autoscaling_group.this.name
     lifecycle {
       ignore_changes = [start_time]
     }
   }
    
resource "aws_autoscaling_schedule" "on" {
  scheduled_action_name  = "on_instance"
  min_size               = local.min
  max_size               = local.max
  desired_capacity       = 1
  start_time             =  "${local.today_date}T18:30:00Z" 
  recurrence             = "30 ${var.hour_to_switch_on} * * *"
  autoscaling_group_name = aws_autoscaling_group.this.name
  lifecycle {
    ignore_changes = [start_time]
  }
}