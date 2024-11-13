output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.kafka_vpc.id
}

output "subnet_id" {
  description = "ID of the created Subnet"
  value       = aws_subnet.kafka_subnet.id
}

output "security_group_id" {
  description = "ID of the created Security Group"
  value       = aws_security_group.kafka_sg.id
}

output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.kafka_instance.id
}

output "instance_public_ip" {
  description = "Public IP of the Kafka EC2 instance"
  value       = aws_instance.kafka_instance.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the Kafka EC2 instance"
  value       = aws_instance.kafka_instance.public_dns
}
