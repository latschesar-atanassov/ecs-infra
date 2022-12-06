// network

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "${local.name_prefix}_vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "public_load_balancer" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name        = "${local.name_prefix}_public_snet_load_balancer"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_api" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name        = "${local.name_prefix}_private_snet_api"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_database" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name        = "${local.name_prefix}_private_snet_database"
    Environment = var.environment
  }

}

// internet gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${local.name_prefix}_igw"
    Environment = var.environment
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
    Environment = var.environment
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route = []

  tags = {
    Name        = "${local.name_prefix}_private_rt"
    Environment = var.environment
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
