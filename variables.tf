variable "aws_region" {
    type = string
    description = "Number of instances"
}
variable "instance_config" {
    type = object({
      ami_id = string,
      instance_type = string,
      instance_count = number,
      instance_name = string
    })
}

# variable "alarm_config" {
#   type = object({
#     alarm_name = string,
#     comparison_operator = string,
#     evaluation_periods = number,
#     metric_name = string,
#     namespace = string,
#     period = number,
#     statistic = string,
#     threshold = number,
#     alarm_description = string
#     alarm_actions = list(string)
#     dimensions = map(string)
#   })
# }

variable "environment" {
  type = string
}