output "instance_id" {
    description = "This is the Id of ec2 instances"
    value = aws_instance.terraform-ec2[*].id
}

output "public_ip" {
    description = "This is the Id of ec2 instances"
    value = aws_instance.terraform-ec2[*].public_ip
}


output "public_dns" {
    description = "This is the Id of ec2 instances"
    value = aws_instance.terraform-ec2[*].public_dns
}