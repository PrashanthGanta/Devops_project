## Application Load Balancer

# This is load balancer for the private instances present in the private subnet
# To access the jenkins and app server hosted on them
# Use www.alb-domain.com/jenkins or www.alb-domain.com/app
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.public_subnets[0],module.vpc.public_subnets[1]]
  security_groups    = [module.Public_Instance_sg.security_group_id]

  # Creating two target groups to access them individually with /jenkins and /app
  target_groups = [
    {
      name_prefix      = "jen-"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "instance"
      targets = [
        {
          target_id = module.ec2_instance_Jenkins.id
          port = 8080
        }
      ]
    },
    {
      name_prefix      = "app-"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "instance"
      targets = [
        {
          target_id = module.ec2_instance_app.id
          port = 8080
        }
      ]
    }

  ]

  
  http_tcp_listeners = [
    # {
    #   port               = 80
    #   protocol           = "HTTP"
    #   actions ={
    #         type               = "forward"
    #         target_group_index = 0
    #       }
    #   condition = {
    #           path_patterns = ["/jenkins", "/jenkins*"]
    #         }
    # },
    {
      port = 80
      protocol = "HTTP"
      target_group_index = 0
      actions = [{
        type        = "redirect"
        path        = "/jenkins"
        protocol    = "HTTP"
      }]
      conditions = [{
        path_patterns = ["/jenkins", "/jenkins*"]
      }]

    }
    ,
    {
      port = 80
      protocol = "HTTP"
      target_group_index = 1
      actions = [{
        type        = "redirect"
        path        = "/app"
        protocol    = "HTTP"
      }]
      conditions = [{
        path_patterns = ["/app", "/app*"]
      }]

    }
    ]
 
  tags = {
    Environment = "Test"
  }
}