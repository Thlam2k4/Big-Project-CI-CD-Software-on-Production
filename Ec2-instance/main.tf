#define AWS provider

provider "aws" {
    region = "ap-northeast-1"
}

#Create an EC2 instance for the master node
module "vpc"{
  source = "./vpc-module"
  vpc_cidr_block = "16.0.0.0/16"
  public_subnet = "16.0.1.0/24"
  zone-public-subnet = "ap-northeast-1a"
}

module "ec2"{
  source = "./ec2-module"
  ami_id = "ami-0d48337b7d3c86f62"
  vpc_id = module.vpc.vpc_id
  key_id = "to-do-key"
  zone = "ap-northeast-1a"
  instance_type = "t2.micro"
  user-data = "user-data-jenkins.sh"

}
output "ec2-public-ip"{
  value = module.ec2.ec2-public-ip
}