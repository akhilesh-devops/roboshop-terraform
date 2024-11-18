module "vpc" {
  source   = "git::https://github.com/akhilesh-devops/tf-module-vpc"

  for_each = var.vpc
  cidr     = each.value["cidr"]
  subnets  = each.value["subnets"]
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr = var.default_vpc_cidr
  default_vpc_route_table_id = var.default_vpc_route_table_id
  tags              = var.tags
  env               = var.env
}

module "alb" {
  source = "git::https://github.com/akhilesh-devops/tf-module-alb.git"

  for_each        = var.alb
  internal        = each.value["internal"]
  alb_type         = each.value["alb_type"]
  sg_ingress_cidr = each.value["sg_ingress_cidr"]
  sg_port         = each.value["sg_port"]
  tags            = var.tags
  env             = var.env
  vpc_id          = each.value["internal"] ? local.vpc_id : var.default_vpc_id
  subnets         = each.value["internal"] ? local.app_subnets : data.aws_subnets.subnets.ids
}
