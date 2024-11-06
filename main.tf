module "vpc" {
  source = "git::https://github.com/akhilesh-devops/tf-module-vpc"

  for_each = var.vpc
  cidr     = each.value["cidr"]
  vpc_name = var.vpc_name
}