variable "instance_config" {
    type = object({
      ami_id = string,
      instance_type = string,
      instance_count = number,
      instance_name = string
    })
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