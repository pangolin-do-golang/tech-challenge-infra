module "api_gateway_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "api-gateway-security-group"
  description = "API Gateway group for example usage"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]

  egress_rules = ["all-all"]
}

module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  # API
  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  description = "HTTP API Gateway with VPC links"
  name        = "api-gateway-tech-challenge"

  # Custom Domain
  create_domain_name = false

  authorizers = {
    "lambda" = {
      authorizer_type  = "REQUEST"
      identity_sources = ["$request.header.Authorization"]
      name             = "lambda-auth"
      authorizer_uri   = var.lambda_auth
      enable_simple_responses = false
      authorizer_payload_format_version = "1.0"
    }
  }

  # Routes & Integration(s)
  routes = {
    "$default" = {
      authorizer_key = "lambda-auth"

      integration = {
        connection_type = "INTERNET"
        type = "HTTP_PROXY"
        uri  = var.cluster_uri
        method = "ANY"
      }
    }
  }
}
