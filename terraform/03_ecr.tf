module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.3.0"

  repository_read_write_access_arns = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/admin"]
  repository_name                   = var.ecr_repository_name

  tags = local.tags
}