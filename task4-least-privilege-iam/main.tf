resource "aws_iam_policy" "ci_pipeline_policy" {
  name   = "ci-pipeline-least-privilege"

  policy = file("${path.module}/ci-policy.json")
}

resource "aws_iam_user_policy_attachment" "ci_attach" {
  user       = aws_iam_user.ci.name
  policy_arn = aws_iam_policy.ci_pipeline_policy.arn
}
