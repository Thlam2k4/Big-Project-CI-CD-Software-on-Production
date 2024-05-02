output "vpc_id"{
    value = aws_vpc.vpc.id
}

output "subnet_id"{
    value = aws_subnet.Public-subnet.id
}