variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "region" {
  description = "The AWS region to create the VPC in"
  type        = string
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "region" {
  value = var.region
}

output "public_subnet_ids" {
  value = [] # Populate with actual subnet IDs
}

output "private_subnet_ids" {
  value = [] # Populate with actual subnet IDs
}

output "route_table_ids" {
  value = [] # Populate with actual route table IDs
}

output "internet_gateway_id" {
  value = "" # Populate with actual internet gateway ID
}

output "nat_gateway_ids" {
  value = [] # Populate with actual NAT gateway IDs
}

output "tags" {
  value = aws_vpc.main.tags
}
