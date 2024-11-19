vpc = {
  main = {
    cidr = "10.0.0.0/16"
    subnets = {
      public = {
        public-1 = { cidr = "10.0.0.0/24", az = "us-east-1a" }
        public-2 = { cidr = "10.0.1.0/24", az = "us-east-1b" }
      }
      app = {
        app-1 = { cidr = "10.0.2.0/24", az = "us-east-1a" }
        app-2 = { cidr = "10.0.3.0/24", az = "us-east-1b" }
      }
      db = {
        db-1 = { cidr = "10.0.4.0/24", az = "us-east-1a" }
        db-2 = { cidr = "10.0.5.0/24", az = "us-east-1b" }
      }
    }
  }
}

default_vpc_id =  "vpc-0bb2ad876599ca0f1"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_route_table_id = "rtb-058289fa903d901c4"

tags = {
  company_name  = "ABC Tech"
  business_unit = "Ecommerce"
  project_name  = "robotshop"
  cost_center   = "ecom_rs"
  created_by    = "terraform"
}

env = "dev"

alb = {
  private = {
    internal = false
    lb_type  = "application"
    sg_ingress_cidr = ["172.31.0.0/16", "10.0.0.0/16"]
    sg_port  = 80
  }
  public = {
    internal = true
    lb_type  = "application"
    sg_ingress_cidr = ["0.0.0.0/0"]
    sg_port  = 80
  }
}

docdb = {
  main = {
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    engine_version          = "4.0.0"
  }
}