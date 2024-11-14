module "vpc" {
  source = "git::https://github.com/akhilesh-devops/tf-module-vpc.git"

  for_each  = var.vpc
  cidr      = lookup(each.value, "cidr", null)
  subnets   = lookup(each.value, "subnets", null)
}