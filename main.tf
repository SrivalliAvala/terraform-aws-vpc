resource "aws_vpc" "main" {
  cidr_block       = var.cidr_vpc
  enable_dns_hostnames = var.enable_dns_hostnames
  
  tags = merge(
    var.common_tags,
    var.vpc_tags, {
        Name = local.resource_name
    }
  ) 
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.common_tags,
    var.igw_tags, {
        Name = local.resource_name
    }
  ) 
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true    #(Optional) Specify true to indicate that instances
  tags = merge(                       #launched into the subnet should be assigned a public IP address. Default is false
    var.common_tags,
    var.public_subnet_tags,
    {
        Name = "${local.resource_name}-public-${local.az_names[count.index]}"
    }
  )
}

resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = local.az_names[count.index]   # we can hard code the name of AZ if needed
    map_public_ip_on_launch = true
    tags = merge(
    var.common_tags,
    var.public_subnet_tags, {
        Name = "${local.resource_name}-private-${local.az_names[count.index]}"
    }
  )    
}

resource "aws_subnet" "database" {
    count = length(var.database_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.database_subnet_cidrs[count.index]
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true
    tags = merge(
    var.common_tags,
    var.public_subnet_tags, {
        Name = "${local.resource_name}-database-${local.az_names[count.index]}"
    }
  )    
}

#DB grouping

resource "aws_db_subnet_group" "db_grouping" {
  name       = "${local.resource_name}"
  #subnet_ids = [aws_subnet.frontend.id, aws_subnet.backend.id]
  subnet_ids = aws_subnet.database[*].id   #since we got database subnet with index such as db[0], db[1]
  tags = merge(
    var.common_tags,
    var.db_group_tags, {
        Name = "${local.resource_name}"
    }
  )  
}

resource "aws_eip" "expense_eip" {
  domain   = "vpc"
  tags = {
    Name = "${local.resource_name}-EIP"
  }

}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.expense_eip.id
  subnet_id     = aws_subnet.public[0].id   #attach to public subnet...only one nat is using...so public[0]
  tags = merge(
    var.common_tags,
    var.nat_tags, {
        Name = "${local.resource_name}"
    }
  ) 

   # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.  

  depends_on = [aws_internet_gateway.igw]   #
}