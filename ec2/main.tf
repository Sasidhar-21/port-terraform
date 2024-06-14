data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  
  filter {
    name   = "tag:Name"
    values = ["public"]
  }
  
  most_recent = true
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  key_name      = var.pem_key_name
  subnet_id     = data.aws_subnet.selected.id

  tags = {
    Name = var.ec2_name
  }
}
