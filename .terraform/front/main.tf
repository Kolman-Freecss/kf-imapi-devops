resource "aws_instance" "angular_server" {
  ami           = "var.ami_id"
  instance_type = "var.instance_type"
  key_name      = "var.key_name"

  tags = {
    Name = "angular-ec2-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              # Update NodeJs and Npm
              curl -sL https://rpm.nodesource.com/setup_18.x | bash -
              yum install -y nodejs

              # Install Angular CLI
              npm install -g @angular/cli

              # Configure Firewall for HTTP
              yum install -y firewalld
              systemctl start firewalld
              firewall-cmd --permanent --add-service=http
              firewall-cmd --reload
              EOF
}

resource "aws_security_group" "angular_sg" {
  name        = "angular_sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.angular_sg.id
  network_interface_id = aws_instance.angular_server.primary_network_interface_id
}