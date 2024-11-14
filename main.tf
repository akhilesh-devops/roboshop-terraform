module "vpc" {
  source = "git::https://github.com/akhilesh-devops/tf-module-vpc.git"

  for_each  = var.vpc
  cidr      = lookup(each.value, "cidr", null)
  subnets   = lookup(each.value, "subnets", null)
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr = var.default_vpc_cidr
  default_vpc_route_table_id = var.default_vpc_route_table_id
}

