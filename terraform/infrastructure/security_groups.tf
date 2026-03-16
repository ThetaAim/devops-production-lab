# --- Load balancer SGs

resource "aws_security_group" "alb_public_sg" {
  name        = "alb_public_sg"
  description = "Allow HTTP from internet"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "alb_public_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb_public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "alb_egress" {
  security_group_id = aws_security_group.alb_public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# --- Private machine SGs

resource "aws_security_group" "ec2_private_sg" {
  name        = "ec2_private_sg"
  description = "Private EC2 - no ingress"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "ec2-private-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "private_allow_all_egress" {
  security_group_id = aws_security_group.ec2_private_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "from_alb" {
  security_group_id            = aws_security_group.ec2_private_sg.id
  referenced_security_group_id = aws_security_group.alb_public_sg.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}


# --- Jenkins Security Group


resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins"
  description = "Allow inbound traffic for Jenkins"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_inbound_jenkins"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_8080" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "0.0.0.0/0" # should set my own ip
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "0.0.0.0/0" # should set my own ip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

}


resource "aws_vpc_security_group_egress_rule" "allow_all_out" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
