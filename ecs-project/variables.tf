variable "cluster_name" {
  type = string
}
variable "ACCESS_TOKEN_SECRET" {
  type = string
}

variable "MONGODB_URL" {
  type = string
}

variable "client-container" {
  description = "container name for frontend"
}

variable "server-container" {
  description = "container name for backend"
}

variable "client-task" {
  description = "taskdefinition for frontend"
}

variable "server-task" {
  description = "taskdefinition for backend"
}

variable "pri-subnets" {
  description = "private subnet for ecs fargate services"
}

variable "pub-subnets" {
  description = "public subnets for  alb"
}

variable "exec-role" {
  description = "execution role for fargate tasks"
}

variable "client-image" {
  description = "image for frontend"
}

variable "server-image" {
  description = "image for backend"
}

variable "client-port" {
  type = number
}

variable "server-port" {
  type =  number
}

variable "sg-01" {
  
}