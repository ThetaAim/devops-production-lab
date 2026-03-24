resource "aws_instance" "jenkins" {

  ami                         = "ami-0e3ce61b0fbdbe6ee"
  instance_type               = "t2.small"
  subnet_id                   = aws_subnet.public_a.id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  key_name                    = "jenkins"

  user_data = <<-EOF
#!/bin/bash
set -eux

DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

apt-get update
# apt install -y git

cd /home/ubuntu

git clone https://github.com/ThetaAim/devops-production-lab.git

cd devops-production-lab/ci/jenkins

docker build -t jenkins-devops .

docker rm -f jenkins 2>/dev/null || true
docker volume rm jenkins_home 2>/dev/null || true

docker network create app-net || true

docker run -d \
  -p 8080:8080 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --group-add $DOCKER_GID \
  --network app-net \
  --name jenkins \
  jenkins-devops

# docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword > /home/ubuntu/jenkins_pass
EOF

  tags = {
    Name = "jenkins-server"
  }
}
