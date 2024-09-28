variable "cidr_vpc" {
    default = "10.0.0.0/16"
  
}
variable "enable_dns_hostnames" {
    default = true
}

# variable "common_tags" {
#     default = {
#         Project = "expense"
#         Terraform = "true"
#         Environment = "dev"
#     } 
# }

variable "project_name" {
    type = string   
}

variable "Environment" {
    type = string
}

variable "common_tags" {
    default = {}
}

variable "igw_tags" {
    default = {}
}

variable "vpc_tags" {
    default = {}
}

variable "vpc_cidr" {

}

variable "public_subnet_cidrs" {
    type = list
    validation {
        condition = length(var.public_subnet_cidrs) == 2
        error_message = "Please provide 2 valid public subnet CIDR"
    }
}

variable "public_subnet_tags" {
    default = {}
}

variable "private_subnet_cidrs" {
    type = list
    validation {
      condition = length(var.private_subnet_cidrs) == 2
      error_message = "please provide two valid private cidrs"
    }
}

variable "private_subnet_tags" {
    default = {}
}

variable "database_subnet_cidrs" {
    type = list
    validation {
      condition = length(var.database_subnet_cidrs) == 2
      error_message = "please provide two valid database cidrs"
    }
}

variable "database_subnet_tags" {
    default = {}
}

variable "db_group_tags" {
  default = {}
}

variable "nat_tags" {
  default = {}
}

