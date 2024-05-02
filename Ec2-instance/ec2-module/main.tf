resource "aws_security_group" "sg-custom"{
    name = "jenkins-server-SG"
    vpc_id = var.vpc_id
    ingress {
        from_port =80
        to_port =80
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
     ingress {
        from_port =8080
        to_port =8080
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
     ingress {
        from_port =3000
        to_port =3000
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
     ingress {
        from_port =22
        to_port =22
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
}


resource "aws_instance" "jenkins_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_id
  vpc_security_group_ids = aws_security_group.sg-custom.id
  user_data = file(var.user-data)

  tags = {
    Name = "Jenkins"
  }
}