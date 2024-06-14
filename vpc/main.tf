provider "aws" {
  region = var.region
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {}
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(
    var.tags,
    {
      Name = var.vpc_name
    }
  )
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, 0)

  tags = merge(
    var.tags,
    {
      Name = "${var.vpc_name}-public"
    }
  )
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "region" {
  value = var.region
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "tags" {
  value = var.tags
}
