provider "aws" {
    region = var.aws_region
}

resource "aws_instance" "Iacinstance" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance-sg.id]
  key_name = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Welcome to ${var.instance_name}!</h1>" > /var/www/html/index.html
              EOF


  tags = {
    Name = "Harnessinstance"
  }
}

resource "aws_security_group" "instance-sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "Harness-instance-sg"
  }
}

