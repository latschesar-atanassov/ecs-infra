locals {
  name_prefix = "demo"
  environment = "test"
  cluster_name = "ecs-fargate"
  repository_name = "ecs-app"
  
  public_alb_target_group = "public_alb_target_group"
  private_alb_target_group = "private_alb_target_group"
}
