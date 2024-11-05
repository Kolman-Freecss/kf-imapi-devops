variable "aws_region" {
  description = "AWS region to deploy the EC2 instance"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
}

variable "instance_type" {
  description = "Type of instance to be created"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the key pair to use for SSH access"
  default     = "angular-ec2"
}
