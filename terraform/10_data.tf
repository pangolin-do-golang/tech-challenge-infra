data "aws_availability_zones" "available" {}
data "aws_ecrpublic_authorization_token" "token" {}
data "aws_caller_identity" "current" {}