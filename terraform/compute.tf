module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = local.cluster_name

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.this.name
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  tags = {
    Name        = "${local.name_prefix}_ecs"
    Environment = local.environment
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecs/${local.cluster_name}"
  retention_in_days = 7


  tags = {
    Name        = "${local.name_prefix}_cw"
    Environment = local.environment
  }
}


module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = local.repository_name

  repository_read_write_access_arns = [data.gha_app_deployer.arn]
  repository_read_access_arns = []
  
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "keep last 30 images",
        selection = {
          tagStatus     = "any",
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = local.environment
  }
}