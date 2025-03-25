resource "aws_instance" "terraform-ec2" {
    ami = var.instance_config.ami_id
    instance_type = var.instance_config.instance_type
    count = var.instance_config.instance_count
    key_name = "zaki-test-codonix"
    tags = {
        Name = var.instance_config.instance_name
    }
    vpc_security_group_ids = [aws_security_group.sg_example.id]
    subnet_id = var.vpc_config.subnet_id
}

resource "aws_security_group" "sg_example" {
  name = var.security_group_name
  description = "Allowing traffic to instances"
  vpc_id = var.vpc_config.vpc_id
  dynamic "ingress" {
    for_each = var.ingress_ports
        content {
            from_port        = ingress.value
            to_port          = ingress.value
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
        }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name        = "Allowing the traffic via terraform config"
  }
}
