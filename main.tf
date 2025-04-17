provider "aws" {
  region = "us-east-1"  
}

resource "aws_instance" "nginx_server" {
  ami           = "ami-0c4e709339fa8521a"  # Ubuntu 24.04 LTS (us-east-1)
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = file("user_data.sh")

  vpc_security_group_ids = [aws_security_group.nginx_sg.id]

  tags = {
    Name = "skTerraformNginxServer"
  }
}

resource "aws_security_group" "nginx_sg" {
  name        = "sknginx-sg"
  description = "Allow HTTP and SSH"

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


