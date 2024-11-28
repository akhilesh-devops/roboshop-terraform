module "vpc" {
  source   = "git::https://github.com/akhilesh-devops/tf-module-vpc.git"

  for_each = var.vpc
  cidr     = each.value["cidr"]
  subnets  = each.value["subnets"]
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr = var.default_vpc_cidr
  default_vpc_route_table_id = var.default_vpc_route_table_id
  tags              = var.tags
  env               = var.env
}

# module "alb" {
#   source   = "git::https://github.com/akhilesh-devops/tf-module-alb.git"
#
#   for_each          = var.alb
#   internal          = each.value["internal"]
#   lb_type           = each.value["lb_type"]
#   sg_ingress_cidr   = each.value["sg_ingress_cidr"]
#   vpc_id            = each.value["internal"] ? local.vpc_id : var.default_vpc_id
#   subnets           = each.value["internal"] ? local.app_subnets : data.aws_subnets.subnets.ids
#   tags              = var.tags
#   env               = var.env
#   sg_port           = each.value["sg_port"]
# }

module "docdb" {
  source = "git::https://github.com/akhilesh-devops/tf-module-docdb.git"

  for_each                = var.docdb
  tags                    = var.tags
  env                     = var.env
  subnet_ids              = local.db_subnets
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  sg_ingress_cidr         = local.app_subnets_cidr
  vpc_id                  = local.vpc_id
  engine_version          = each.value["engine_version"]
  instance_class          = each.value["instance_class"]
  instance_count          = each.value["instance_count"]
}

module "rds" {
  source                  = "git::https://github.com/akhilesh-devops/tf-module-rds.git"

  for_each                = var.rds
  tags                    = var.tags
  env                     = var.env
  subnet_ids              = local.db_subnets
  vpc_id                  = local.vpc_id
  rds_type                = each.value["rds_type"]
  sg_ingress_cidr         = local.app_subnets_cidr
  db_port                 = each.value["db_port"]
  engine_family           = each.value["engine_family"]
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  instance_class          = each.value["instance_class"]
  instance_count          = each.value["instance_count"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
}

module "elasticache" {
  source                    = "git::https://github.com/akhilesh-devops/tf-module-elasticache.git"

  for_each                  = var.elasticache
  tags                      = var.tags
  env                       = var.env
  subnet_ids                = local.db_subnets
  port                      = each.value["port"]
  sg_ingress_cidr           = local.app_subnets_cidr
  vpc_id                    = local.vpc_id
  family                    = each.value["family"]
  engine_version            = each.value["engine_version"]
  num_cache_nodes           = each.value["num_cache_nodes"]
  node_type                 = each.value["node_type"]
  engine                    = each.value["engine"]
  elasticache_type          = each.value["elasticache_type"]
}

module "rabbitmq" {
  source                    = "git::https://github.com/akhilesh-devops/tf-module-rabbitmq.git"
  tags                      = var.tags
  env                       = var.env
  zone_id                   = var.zone_id

  for_each                  = var.rabbitmq

  vpc_id                    = local.vpc_id
  subnet_ids                = local.db_subnets
  sg_ingress_cidr           = local.app_subnets_cidr
  instance_type             = each.value["instance_type"]
  ssh_ingress_cidr          = var.ssh_ingress_cidr
}







