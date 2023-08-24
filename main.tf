provider "aws" {
  region = "eu-central-1"
  access_key = "AKIA4KLA2JDGH4L3BSMJ"
  secret_key = "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"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6"
    }
  }
}

terraform {
  backend "local" {
    path = "/Users/manishalankala/github/user2/aws-tf-state/terraform.tfstate"
  }
}

resource "aws_iam_user" "github_iam_user" {
  name = "github-user"
  path          = "/"
  tags = {
    tag-key = "Account used in Github actions to push docker images to ECR"
  }
}

resource "aws_iam_access_key" "github_user_access_key" {
  user = aws_iam_user.github_iam_user.name
  depends_on = [aws_iam_user.github_iam_user]
}


output "github_user_access_key" {
  value = aws_iam_access_key.github_user_access_key.id
}

output "secret" {
  value = aws_iam_access_key.github_user_access_key.encrypted_secret
}


resource "aws_iam_user_login_profile" "github_iam_user_profile" {
  user    = aws_iam_user.github_iam_user.name
}

output "password" {
  value = aws_iam_user_login_profile.github_iam_user_profile.encrypted_password
}


resource "aws_iam_policy" "github_ecr_authorization_policy" {
  name        = "github-ecr-auth-policy"
  description = "ECR authorization policy to authenticate with ECR"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ECRGetAuthorizationToken",
            "Effect": "Allow",
            "Action": "ecr:GetAuthorizationToken",
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_policy" "github_ecr_policy" {
  name        = "github-ecr-policy"
  description = "ECR policy to get and push images to repo we created earlier"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowPush",
        "Effect": "Allow",
        "Action": [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:DescribeImages",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:ListTagsForResource",
          "ecr:PutImageTagMutability",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "ecr:CompleteLayerUpload"
        ],
        "Resource": "*"
      }
    ]
  })
}


resource "aws_iam_policy_attachment" "github_user_auth_ecr_policy_attachment" {
  name       = "github-user-auth-ecr-policy-attachment"
  policy_arn = aws_iam_policy.github_ecr_authorization_policy.arn
  users      = [aws_iam_user.github_iam_user.name]
}


resource "aws_iam_policy_attachment" "github_user_ecr_policy_attachment" {
  name       = "github-user-ecr-policy-attachment"
  policy_arn = aws_iam_policy.github_ecr_policy.arn
  users      = [aws_iam_user.github_iam_user.name]
}



# Create ECR repository
resource "aws_ecr_repository" "my_ecr" {
  name = "my-ecr"
}

# Attach ECR policy to the IAM user
resource "aws_iam_policy_attachment" "github_user_ecr_repo_attachment" {
  name       = "github-user-ecr-repo-attachment"
  policy_arn = aws_iam_policy.github_ecr_policy.arn
  users      = [aws_iam_user.github_iam_user.name]
  depends_on = [aws_ecr_repository.my_ecr]
}

# Outputs
output "ecr_repo_url" {
  value = aws_ecr_repository.my_ecr.repository_url
}

# Data source to retrieve ECR authorization token
#data "aws_ecr_authorization_token" "my_ecr_auth" {}

#output "ecr_registry_username" {
#  value = base64decode(data.aws_ecr_authorization_token.my_ecr_auth.authorization_token)[0]
#}

#output "ecr_registry_password" {
#  value = base64decode(data.aws_ecr_authorization_token.my_ecr_auth.authorization_token)[1]
#}