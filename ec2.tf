# key pair (login)

resource "aws_key_pair" "my_key" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("infra-app-key.pub")
  tags = {
    Environment = var.env
  }

}

# VPC & Security Group
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my-security" {
  name        = "${var.env}-automate-sg"
  description = "TF gerarated security group"
  vpc_id      = aws_default_vpc.default.id #interpolation

  #inbound rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Flask-app"
  }

  #outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-infra-app-sg"
  }
}

# ec2 intance

resource "aws_instance" "my_instance" {
  # count = var.ec2_instance_count # Meta arguement

  count = var.instance_count

  depends_on = [ aws_security_group.my-security , aws_key_pair.my_key ]
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my-security.name]
  instance_type   = var.instance_type
  ami             = var.ami_id # ubuntu
  user_data       = file("requerment.sh")

  root_block_device {
    volume_size = var.env == "prd" ? 20 : 10   # conditional statement +
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.env}-infra-app-instance"
    Environment = var.env
  }

}