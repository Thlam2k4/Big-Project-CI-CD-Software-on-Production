#!/bin/bash
  echo "Hello World" > hi.txt
  sudo yum update -y
  sudo yum install docker -y
  
  sudo usermod -a -G docker ec2-user
  sudo systemctl enable docker 
  sudo systemctl start docker 

  docker run -p 8080:8080 -p 50000:50000 \
	   --name my_jenkins --privileged \
	   -v /var/run/docker.sock:/var/run/docker.sock \
	   -v jenkins_home:/var/jenkins_home \
	   --group-add $(stat -c '%g' /var/run/docker.sock) \
	   -d khaliddinh/jenkins
   