resource "aws_ecr_repository" "app_repo" {
  name                 = "devops-lab-app"
  image_tag_mutability = "MUTABLE"

  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name = "devops-lab-ecr"
  }
}

