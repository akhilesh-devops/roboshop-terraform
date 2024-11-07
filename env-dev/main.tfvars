vpc = {
  main = {
    cidr = "10.0.0.0/16"
    subnets = {
      public = {
        public-1 = { az = "us-east-1a", cidr = "10.0.0.0/24" }
        public-2 = { az = "us-east-1b", cidr = "10.0.1.0/24" }
      }
      app = {
        app-1 = { az = "us-east-1a", cidr = "10.0.2.0/24" }
        app-2 = { az = "us-east-1b", cidr = "10.0.3.0/24" }
      }
      db = {
        db-1 = { az = "us-east-1a", cidr = "10.0.4.0/24" }
        db-2 = { az = "us-east-1b", cidr = "10.0.5.0/24" }
      }
    }
  }
}

default_vpc_id = "vpc-0bb2ad876599ca0f1"
default_vpc_cidr = "172.31.0.0/16"
default_route_table_id = "rtb-058289fa903d901c4"
