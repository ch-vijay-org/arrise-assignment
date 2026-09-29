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
