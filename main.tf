
provider "aws" {
    region = var.aws_region
}   

module "WebServer" {
  source = "./modules/ec2"
  instance_count = 1
  instance_name = "My TF Web Server"
  security_group_name = "Modified security group for webserver"
}

module "BackendServer" {
  source = "./modules/ec2"
  instance_count = 1
  instance_name = "My TF Backend Server"
  security_group_name = "Modified security group for backend"
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

resource "aws_s3_bucket" "example" {
  bucket = "my-zaki-tf-new-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# resource "aws_dynamodb_table" "basic-dynamodb-table" {
#   name           = "terraform-lock"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key =  "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

terraform {
  backend "s3" {
    bucket = "my-zaki-tf-test-bucket"
    region = "ap-south-1"
  }
}