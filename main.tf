
provider "aws" {
    region = var.aws_region
}   

module "WebServer" {
  source = "./modules/ec2"
  instance_config = {
    ami_id = var.instance_config.ami_id
    instance_count = var.instance_config.instance_count
    instance_type = var.instance_config.instance_type
    instance_name = "Webserver-${var.instance_config.instance_name}"
  }
    security_group_name = "Modified security group for webserver"
}
module "BackendServer" {
  source = "./modules/ec2"
  instance_config = {
  ami_id = var.instance_config.ami_id
    instance_count = var.instance_config.instance_count
    instance_type = var.instance_config.instance_type
    instance_name = "Backend-${var.instance_config.instance_name}"
  }
  security_group_name = "Modified security group for backend"
}

resource "aws_sns_topic" "alarms" {
  name = "${terraform.workspace}-alarms"
}

module "webserver_cpu_alarm" {
  source = "./modules/cloudwatch"
  count = var.environment == "prod" ? var.instance_config.instance_count : 0
  alarm_config = {
    alarm_name = "${terraform.workspace}-webserver-high-cpu-${count.index +1}"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 5
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 60
    statistic = "Average"
    threshold = 5,
    alarm_description = "This is a test monitor created for prod resources"
    alarm_actions = [ "arn:aws:sns:us-east-1:905418317311:Default_CloudWatch_Alarms_Topic" ]
    dimensions = {
      InstanceId = module.WebServer.instance_id[count.index]
    }
  }
}
# module "WebServer_security" {
#   source = "./modules/ec2"
#   instance_count = 1
#   instance_name = "My TF Web Server"
# }

# resource "aws_instance" "terraform-ec2-front" {
#     # ami = "ami-05c179eced2eb9b5b"
#     ami = var.ami_id
#     # instance_type = "t2.micro"
#     instance_type = var.instance_type
#     # count = 2
#     count = var.instance_count

#     tags = {
#         Name = var.instance_name
#     }
# }

# resource "aws_s3_bucket" "example" {
#   bucket = "my-zaki-tf-new-test-bucket"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }

# resource "aws_dynamodb_table" "basic-dynamodb-table" {
#   name           = "terraform-lock"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key =  "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# terraform {
#   backend "s3" {
#     bucket = "my-zaki-tf-test-bucket"
#     region = "ap-south-1"
#   }
# }