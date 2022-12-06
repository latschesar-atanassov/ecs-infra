// network

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_load_balancer" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "private_api" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "private_database" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"

}

// internet gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

// route tables

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route = []
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