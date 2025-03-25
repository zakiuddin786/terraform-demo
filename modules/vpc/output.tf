output "vpc_id" {
  value = aws_vpc.terraform-created-vpc.id
}

output "subnet_id" {
    value = aws_subnet.main.id
}