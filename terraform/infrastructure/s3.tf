resource "aws_s3_bucket" "jenkins_backup" {
  bucket = "jenkins-backup-512741504354"
  count  = var.enable_s3 ? 1 : 0

  tags = {
    Name        = "jenkins-backup"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "jenkins_versioning" {
  count  = var.enable_s3 ? 1 : 0
  bucket = aws_s3_bucket.jenkins_backup[count.index].id

  versioning_configuration {
    status = "Enabled"
  }
}

