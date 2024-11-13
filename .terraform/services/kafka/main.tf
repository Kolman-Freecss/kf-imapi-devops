resource "aws_vpc" "kafka_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "kafka_vpc"
  }
}

resource "aws_subnet" "kafka_subnet" {
  vpc_id            = aws_vpc.kafka_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "kafka_subnet"
  }
}

resource "aws_internet_gateway" "kafka_ig" {
  vpc_id = aws_vpc.kafka_vpc.id

  tags = {
    Name = "kafka_ig"
  }
}

resource "aws_route_table" "kafka_route_table" {
  vpc_id = aws_vpc.kafka_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kafka_ig.id
  }

  tags = {
    Name = "kafka_route_table"
  }
}

resource "aws_route_table_association" "kafka_route_association" {
  subnet_id      = aws_subnet.kafka_subnet.id
  route_table_id = aws_route_table.kafka_route_table.id
}

resource "aws_security_group" "kafka_sg" {
  vpc_id = aws_vpc.kafka_vpc.id

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kafka_sg"
  }
}