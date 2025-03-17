resource "aws_instance" "terraform-ec2" {
    # ami = "ami-05c179eced2eb9b5b"
    ami = var.ami_id
    # instance_type = "t2.micro"
    instance_type = var.instance_type
    # count = 2
    count = var.instance_count
    key_name = "zaki-test"
    tags = {
        Name = var.instance_name
    }

    # connection {
    #   type = "ssh"
    #   user = "ec2-user"
    #   private_key = file("/Users/zakimd/Desktop/devops/zaki-key.pem")
    #   host = self.public_ip
    # }

    # provisioner "remote-exec" {
    #   inline = [ 
    #     "sudo yum update -y",
    #     "sudo yum install nginx",
    #     "sudo systemctl start nginx",
    #     "sudo systemctl enable nginx",
    #    ]
    # }
}

resource "aws_security_group" "sg_example" {
  name = var.security_group_name
  description = "Allowing traffic to instances"

  dynamic "ingress" {
    for_each = var.ingress_ports
        content {
            from_port        = ingress.value
            to_port          = ingress.value
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
        }
    # ipv6_cidr_blocks = ["::/0"]
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
