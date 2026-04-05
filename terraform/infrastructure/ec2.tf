resource "aws_instance" "ec2_micro_ecr" {
  count = 2

  ami           = "ami-0e3ce61b0fbdbe6ee" # Self made Image with Packer
  instance_type = "t3.micro"

  subnet_id                   = element([aws_subnet.private_a.id, aws_subnet.private_b.id], count.index)
  vpc_security_group_ids      = [aws_security_group.ec2_private_sg.id]
  associate_public_ip_address = false
  key_name                    = "jenkins"
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
#!/bin/bash

echo "$HOSTNAME Boot from custom AMI with Docker" > /home/ubuntu/boot.txt

ACCOUNT=$(aws sts get-caller-identity --query Account --output text)

aws ecr get-login-password --region eu-central-1 \
| docker login --username AWS \
--password-stdin $ACCOUNT.dkr.ecr.eu-central-1.amazonaws.com

EOF

  tags = {
    Name = "ec2-micro-ecr-${count.index}"
    Role = "app"
  }
}
