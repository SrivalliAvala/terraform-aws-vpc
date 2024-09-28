data "aws_availability_zones" "available" {   #quering using datasources
  state = "available"   #availability zone is already provided in provider.tf as us-east-1....so it gives that data
}                       #use output.tf to check
