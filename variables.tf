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
    default = "expense"
}

variable "environment" {
    type = string
    default = "dev" 
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
    default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
    type = list
    default = ["10.0.1.0/24", "10.0.2.0/24"]
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
    default = ["10.0.11.0/24", "10.0.12.0/24"]
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
    default = ["10.0.21.0/24", "10.0.22.0/24"]
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

variable "public_route_table_tags" {
    default = {}
}

variable "private_route_table_tags" {
    default = {}
}

variable "database_route_table_tags" {
    default = {}
}

variable "is_peering_required" {
    type = bool
    default = false
}

variable "vpc_peering_tags" {
    default = {}
}
