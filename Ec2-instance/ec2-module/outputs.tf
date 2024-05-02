output "ec2-public-ip"{
    value = aws_instance.jenkins_instance.public_ip
}