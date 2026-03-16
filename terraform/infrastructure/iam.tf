# --- EC2 IAM Role

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# --- Policies ---

# --- Custom policy for pushing to ECR

resource "aws_iam_policy" "ecr_push_policy" {
  name = "jenkins-ecr-push"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:BatchGetImage"
        ]
        Resource = "*"
      }
    ]
  })
}

# --- Policy for S3

resource "aws_iam_policy" "jenkins_backup_s3" {
  count = var.enable_s3 ? 1 : 0

  name        = "jenkins_backup_s3"
  description = "S3 versioning backups for Jenkins"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = aws_s3_bucket.jenkins_backup[count.index].arn
      },
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.jenkins_backup[count.index].arn}/*"
      },
    ]
  })
}


# --- Attach policies

# --- ECR attach policy

resource "aws_iam_role_policy_attachment" "ecr_push_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ecr_push_policy.arn
}

#  SSM attach policy

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# S3 policy attachment

 resource "aws_iam_role_policy_attachment" "s3_attach" {
  count = var.enable_s3 ? 1 : 0

  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.jenkins_backup_s3[count.index].arn
 }

# --- Instance profile

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name
}
