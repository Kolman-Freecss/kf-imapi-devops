output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.angular_server.id
}

output "public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.angular_server.public_ip
}

output "public_dns" {
  description = "The public DNS of the EC2 instance"
  value       = aws_instance.angular_server.public_dns
}
