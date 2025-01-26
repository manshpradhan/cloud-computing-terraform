provider "aws" {
  region = "ap-southeast-2" # Change to your desired region
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2_key_pair"
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_open_ports_sg"
  description = "Security group for EC2 instance to allow SSH, UDP 1194, and TCP 943"

  ingress {
    description = "Allow SSH (port 22) from all sources"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow UDP 1194 from all sources"
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow TCP 943 from all sources"
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}

resource "aws_instance" "ec2" {
  ami           = "ami-00c97da679c04f4a0" # Change to a valid AMI ID for your region
  instance_type = "t3a.small"
  key_name      = aws_key_pair.ec2_key.key_name
  security_groups = [
    aws_security_group.ec2_sg.name
  ]

  tags = {
    Name = "ec2_instance_ovpn"
  }
}

output "private_key_pem" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}