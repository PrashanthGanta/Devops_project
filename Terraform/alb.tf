module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.public_subnets[0],module.vpc.public_subnets[1]]
  security_groups    = [module.Public_ALB_sg.security_group_id]

#   access_logs = {
#     bucket = "upgrad-assignment-m4"
#   }

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
        {
          target_id = module.ec2_instance_Jenkins.id
          port = 8080
        }
      ]
    }
  ]

  # frontend_http_tcp =[
    
    #   {
    #   https_listener_index = 0
    #   priority             = 5000

    #   actions = [{
    #     type        = "redirect"
    #     status_code = "HTTP_302"
    #     host        = "www.youtube.com"
    #     path        = "/watch"
    #     query       = "v=dQw4w9WgXcQ"
    #     protocol    = "HTTPS"
    #   }]

    #   conditions = [{
    #     path_patterns = ["/onboarding", "/docs"]
    #   }]
    # }
  # ]
  
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      # target_group_index = 0
      # action_type = "forward"
      actions ={
            type               = "forward"
            target_group_index = 0
          }
      condition = {
              path_patterns = ["/jenkins", "/jenkins*"]
            }
    },
    {
      port = 80
      protocol = "HTTP"
      target_group_index = 0
      actions = [{
        type        = "redirect"
        # status_code = "HTTP_302"
        # host        = "www.youtube.com"
        path        = "/jenkins"
        # query       = "v=dQw4w9WgXcQ"
        protocol    = "HTTP"
      }]
      conditions = [{
        path_patterns = ["/jenkins", "/jenkins"]
      }]

    }
    # {
    #   https_listener_index = 0
    #   priority             = 10

    #   actions = [{
    #     type        = "redirect"
    #     path        = "/jenkins"
    #     query       = "v=dQw4w9WgXcQ"
    #     protocol    = "HTTP"
    #   }]

    #   conditions = [{
    #     path_patterns = ["/jenkins", "/jenkins*"]
    #   }]
    # }

    ]

  # http_tcp_listeners = [
  #   {
  #     port        = 8080
  #     protocol    = "HTTP"
  #     action_type = "redirect"
      
  #     redirect = {
  #       target_group_index = 0
  #     }
  #     conditions = [{
  #         path_patterns = ["/jenkins", "/jenkins*"]
  #       }]
  #   }
  # ]


  # http_tcp_listeners  = [
  #     {
  #       http_listener_index = 0
  #       priority             = 1

  #       actions = [{
  #         type        = "redirect"
  #         # status_code = "HTTP_302"
  #         # host        = "www.youtube.com"
  #         # path        = "/jenkins"
  #         port               = 80
  #         protocol           = "HTTP"
  #         target_group_index = 0
  #       }]

  #       conditions = [{
  #         path_patterns = ["/jenkins", "/jenkins/*"]
  #       }]
  #     },
      
  #   ]
  
  tags = {
    Environment = "Test"
  }
}