provider "aws" {
    region = var.aws_region
}

resource "aws_instance" "Iacinstance" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance-sg.id]
  key_name = var.key_name

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

