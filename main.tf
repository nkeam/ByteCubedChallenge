variable "hostname" {
  default = "dev"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "server" {
  ami             = "ami-00eb20669e0990cb4"
  instance_type   = "t2.micro"
  security_groups = ["allow_http"]
  user_data       = <<-EOF
    #!bin/bash
    sudo mkdir -p /app/html
    sudo echo "ByteCubed Challenge ${var.hostname}" >> /app/html/index.html
    sudo yum update -y
    sudo yum install docker -y
    sudo service docker start
    sudo docker run -p 8080:80 -v /app/html:/usr/share/nginx/html -d nginx 
  EOF
  provisioner "local-exec" {
    command = "echo 'App can be found here: http://${aws_instance.server.public_dns}:8080'"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic and all outbound traffic"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch" {
  alarm_name                = "high-cpu"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "Monitors cpu"
  insufficient_data_actions = []
  dimensions = {
    InstanceId = "${aws_instance.server.id}"
  }
}