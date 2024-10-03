data "aws_availability_zones" "available" {   #quering using datasources
  state = "available"   #availability zone is already provided in provider.tf as us-east-1....so it gives that data
}                       #use output.tf to check

data "aws_vpc" "default" {
  default = true
}

data "aws_route_table" "main"{
  vpc_id = data.aws_vpc.default.id
  filter {
    name = "association.main"
    values = ["true"]
  }
}