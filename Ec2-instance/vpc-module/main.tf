resource "aws_vpc" "vpc"{
    cidr_block = var.vpc_cidr_block
    tags = {
        "Name" = "Vpc-custom-jenkins-server"
    }
}

resource "aws_subnet" "Public-subnet"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet
    availability_zone = var.zone-public-subnet
    tags = {
        "Name" = "Public-Subnet-jenkins-server"
    }
}


resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.vpc.id
    tags = {
        "Name" = "IGW-custom-jenkins-server"
    }
}
resource "aws_route_table" "rtb"{
    vpc_id = aws_vpc.vpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        "Name" = "rtb-custom-jenkins-server"
    }
}
resource "aws_route_table_association" "public"{
    subnet_id = aws_subnet.Public-subnet.id
    
    route_table_id = aws_route_table.rtb.id

}