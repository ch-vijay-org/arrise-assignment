##Fixed Trust Policy
data "aws_iam_policy_document" "roleC_trust" {

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::000000000000:role/roleB"
      ]
    }
  }
}

##Fixed Permissions Policy
resource "aws_iam_role_policy" "roleC_s3" {

  name = "roleC-s3-access"

  role = aws_iam_role.roleC.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = "arn:aws:s3:::project-data-prod"
      },

      {
        Effect = "Allow"

        Action = [
          "s3:*"
        ]

        Resource = "arn:aws:s3:::project-data-prod/*"
      }
    ]
  })
}
