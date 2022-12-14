// network

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${local.name_prefix}_vpc"
    Environment = local.environment
  }
}

resource "aws_subnet" "public_snet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name        = "${local.name_prefix}_public_snet_a"
    Environment = local.environment
  }
}

resource "aws_subnet" "public_snet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name        = "${local.name_prefix}_public_snet_b"
    Environment = local.environment
  }
}

resource "aws_subnet" "public_snet_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-central-1c"

  tags = {
    Name        = "${local.name_prefix}_public_snet_c"
    Environment = local.environment
  }
}

resource "aws_subnet" "private_snet_alb_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_snet_alb_a_cidr_block
  availability_zone = "eu-central-1a"
  tags = {
    Name        = "${local.name_prefix}_private_snet_alb_a"
    Environment = local.environment
  }
}

resource "aws_subnet" "private_snet_alb_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_snet_alb_b_cidr_block
  availability_zone = "eu-central-1b"
  tags = {
    Name        = "${local.name_prefix}_private_snet_alb_b"
    Environment = local.environment
  }
}

resource "aws_subnet" "private_snet_alb_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_snet_alb_c_cidr_block
  availability_zone = "eu-central-1c"
  tags = {
    Name        = "${local.name_prefix}_private_snet_alb_c"
    Environment = local.environment
  }
}

resource "aws_subnet" "private_snet_app_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_snet_app_a_cidr_block
  availability_zone = "eu-central-1a"
  tags = {
    Name        = "${local.name_prefix}_private_snet_app_a"
    Environment = local.environment
  }
}

resource "aws_subnet" "private_snet_app_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_snet_app_b_cidr_block
  availability_zone = "eu-central-1b"
  tags = {
    Name        = "${local.name_prefix}_private_snet_app_b"
    Environment = local.environment
  }
}

resource "aws_subnet" "private_snet_app_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_snet_app_c_cidr_block
  availability_zone = "eu-central-1c"
  tags = {
    Name        = "${local.name_prefix}_private_snet_app_c"
    Environment = local.environment
  }
}

resource "aws_subnet" "private_snet_data_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.21.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name        = "${local.name_prefix}_private_snet_data_a"
    Environment = local.environment
  }
}

resource "aws_subnet" "private_snet_data_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.22.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name        = "${local.name_prefix}_private_snet_data_b"
    Environment = local.environment
  }
}

resource "aws_subnet" "private_snet_data_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.23.0/24"
  availability_zone = "eu-central-1c"

  tags = {
    Name        = "${local.name_prefix}_private_snet_data_c"
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

resource "aws_route_table_association" "public_snet_a_rta" {
  subnet_id      = aws_subnet.public_snet_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_snet_b_rta" {
  subnet_id      = aws_subnet.public_snet_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_snet_c_route_rta" {
  subnet_id      = aws_subnet.public_snet_c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_snet_app_a_rta" {
  subnet_id      = aws_subnet.private_snet_app_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_snet_app_b_rta" {
  subnet_id      = aws_subnet.private_snet_app_b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_snet_app_c_rta" {
  subnet_id      = aws_subnet.private_snet_app_c.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_snet_data_a_rta" {
  subnet_id      = aws_subnet.private_snet_data_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_snet_data_b_rta" {
  subnet_id      = aws_subnet.private_snet_data_b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_snet_data_c_rta" {
  subnet_id      = aws_subnet.private_snet_data_c.id
  route_table_id = aws_route_table.private.id
}


resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.eu-central-1.s3"
  route_table_ids = [
    aws_route_table.private.id
  ]
}

resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-central-1.logs"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.private_vpc_endpoints.id,
  ]

  subnet_ids = [
    aws_subnet.private_snet_app_a.id,
    aws_subnet.private_snet_app_b.id,
    aws_subnet.private_snet_app_c.id,
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-central-1.ecr.dkr"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.private_vpc_endpoints.id,
  ]

  subnet_ids = [
    aws_subnet.private_snet_app_a.id,
    aws_subnet.private_snet_app_b.id,
    aws_subnet.private_snet_app_c.id,
  ]

  private_dns_enabled = true
}


resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-central-1.ecr.api"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.private_vpc_endpoints.id,
  ]

  subnet_ids = [
    aws_subnet.private_snet_app_a.id,
    aws_subnet.private_snet_app_b.id,
    aws_subnet.private_snet_app_c.id,
  ]

  private_dns_enabled = true
}

// security group

resource "aws_security_group" "public_alb" {
  name   = "public_alb"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.vpc_cidr_block]
  }

  tags = {
    Name        = "public_alb"
    Environment = local.environment
  }
}

resource "aws_security_group" "private_alb" {
  name   = "private_alb"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = [var.vpc_cidr_block]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.vpc_cidr_block]
  }

  tags = {
    Name        = "private_alb"
    Environment = local.environment
  }
}

resource "aws_security_group" "private_vpc_endpoints" {
  name   = "private_vpc_endpoints"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.vpc_cidr_block]
  }

  tags = {
    Name        = "private_vpc_endpoints"
    Environment = local.environment
  }
}



