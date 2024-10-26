resource "aws_instance" "kafka_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.kafka_subnet.id
  security_groups = [aws_security_group.kafka_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              # Install updates and Docker
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              
              # Install Docker Compose
              curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-\$(uname -s)-\$(uname -m)" -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose

              # Create Docker Compose file for Kafka and Zookeeper
              cat <<EOT > /home/ec2-user/docker-compose.yml
              version: '2'
              services:
                zookeeper:
                  image: wurstmeister/zookeeper:3.4.6
                  ports:
                    - "2181:2181"
                kafka:
                  image: wurstmeister/kafka:latest
                  ports:
                    - "9092:9092"
                  environment:
                    KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://\$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):9092
                    KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
                    KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT
                    KAFKA_INTER_BROKER_LISTENER_NAME: PLAINTEXT
                    KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
              EOT

              # Start Kafka and Zookeeper
              cd /home/ec2-user
              docker-compose up -d
              EOF

  tags = {
    Name = "kafka_instance"
  }
}
