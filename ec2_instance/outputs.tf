output "instance_id" {
    value = aws_instance.Iacinstance.id
}

output "public_ip" {
    value = aws_instance.Iacinstance.public_ip
}

output "security_group_id" {
    value = aws_security_group.instance-sg.id
}