##########################################
# Cluster for tasking web app for both client and server side
##########################################

resource "aws_ecs_cluster" "cluster01" {
name = var.cluster_name
}

##################################
# Taskdefinition For  Frontend
##################################

resource "aws_ecs_task_definition" "client" {
  family                   = var.client-task
  requires_compatibilities = ["FARGATE"]
  # required for Fargate launch type
  execution_role_arn  = var.exec-role
  memory       = 512
  cpu          = 256
  network_mode = "awsvpc"

  container_definitions = jsonencode([
    {
      name      = "${var.client-container}"
      image     = "${var.client-image}"
      cpu       = 0 # take up proportional cpu
      essential = true

      portMappings = [
        {
          containerPort = "${var.client-port}"
          hostPort      = "${var.client-port}" # though, access to the ephemeral port range is needed to connect on EC2, the exact port is required on Fargate from a security group standpoint.
          protocol      = "tcp"
        }
      ]

      # Enivironment Variables For Frontend
      environment = [
        
        {
          name  = "REACT_APP_API_KEY"
          value = "http://${aws_lb.server_alb.dns_name}/api"
        }
        
      ]
    }
  ])
}

##################################
# Taskdefinition For  Backend
##################################

resource "aws_ecs_task_definition" "server" {
  family                   = var.server-task
  requires_compatibilities = ["FARGATE"]
  # required for Fargate launch type
  execution_role_arn  = var.exec-role
  memory       = 512
  cpu          = 256
  network_mode = "awsvpc"

  container_definitions = jsonencode([
    {
      name      = "${var.server-container}"
      image     = "${var.server-image}"
      cpu       = 0 # take up proportional cpu
      essential = true

      portMappings = [
        {
          containerPort = "${var.server-port}"
          hostPort      = "${var.server-port}"
          protocol      = "tcp"
        }
      ]

      # Enivironment Variables For Backend
      environment = [
        
        {
          name  = "ACCESS_TOKEN_SECRET"
          value = "${var.ACCESS_TOKEN_SECRET}"
        },

        {
          name  = "MONGODB_URL"
          value = "${var.MONGODB_URL}"
        }

      ]
    }
  ])
}

###################################
# Frontend Service
###################################

resource "aws_ecs_service" "client" {
  name            = "client-2"
  cluster         = aws_ecs_cluster.cluster01.arn
  task_definition = aws_ecs_task_definition.client.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.client_alb_targets.arn
    container_name   = var.client-container
    container_port   = var.client-port
  }

  network_configuration {
    subnets          = var.pri-subnets
    assign_public_ip = true
    security_groups = var.sg-01
  }
}

resource "aws_ecs_service" "server" {
  name            = "server-2"
  cluster         = aws_ecs_cluster.cluster01.arn
  task_definition = aws_ecs_task_definition.server.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.server_alb_targets.arn
    container_name   = var.server-container
    container_port   = var.server-port
  }

  network_configuration {
    subnets          = var.pri-subnets
    assign_public_ip = true
    security_groups = var.sg-01
  }
}