// network

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${local.name_prefix}_vpc"
    Environment = local.environment
  }
}

resource "aws_subnet" "public_load_balancer" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name        = "${local.name_prefix}_public_snet_load_balancer"
    Environment = local.environment
  }
}

resource "aws_subnet" "private_api" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_snet_api_cidr
  tags = {
    Name        = "${local.name_prefix}_private_snet_api"
    Environment = local.environment
  }
}

resource "aws_subnet" "private_database" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name        = "${local.name_prefix}_private_snet_database"
    Environment = local.environment
  }

}

// internet gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${local.name_prefix}_igw"
    Environment = local.environment
  }
}

// route tables

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${local.name_prefix}_public_rt"
    Environment = local.environment
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route = []

  tags = {
    Name        = "${local.name_prefix}_private_rt"
    Environment = local.environment
  }
}

resource "aws_route_table_association" "public_load_balancer_route_table" {
  subnet_id      = aws_subnet.public_load_balancer.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_api_route_table" {
  subnet_id      = aws_subnet.private_api.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_database_route_table" {
  subnet_id      = aws_subnet.private_database.id
  route_table_id = aws_route_table.private.id
}

resource "aws_vpc_endpoint" "ecr" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-central-1.ecr.dkr"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc_endpoint_ecr.id,
  ]

  private_dns_enabled = true
}

// security group

resource "aws_security_group" "vpc_endpoint_ecr" {
  name   = "demo_ecr_security_group"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.private_snet_api_cidr]
  }
}
