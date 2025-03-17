

variable "ami_id" {
    type = string
    default = "ami-05c179eced2eb9b5b"
    description = "This is the AMI id of AL2 in ap-south-1 region"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
    description = "This is type of ec2 instance to launch"
}

variable "instance_count" {
    type = number
    default = 3
    description = "Number of instances"
}

variable "instance_name" {
    type = string
    default = "Terraform-created"
    description = "Name of my instances"
}


variable "security_group_name" {
    type = string
    default = "Terraform-created-group"
    description = "Name of my instances"
}

variable "ingress_ports" {
    type = list(number)
    description = "List of ingress ports to be added"
    default = [ 22, 80, 443, 8080, 3000, 8000 ]
}