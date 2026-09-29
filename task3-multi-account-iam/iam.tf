data "aws_caller_identity" "account_a" {
  provider = aws.account_a
}
 
data "aws_caller_identity" "account_b" {
  provider = aws.account_b
}
 
# ============================================================
# GROUP 1
# ============================================================
 
resource "aws_iam_group" "group1" {
  provider = aws.account_a
 
  name = "group1"
}
 
resource "aws_iam_user" "engine" {
  provider = aws.account_a
 
  name = "engine"
}
 
resource "aws_iam_user" "ci" {
  provider = aws.account_a
 
  name = "ci"
}
 
resource "aws_iam_user_group_membership" "group1_membership" {
  provider = aws.account_a
 
  name = "group1-membership"
 
  users = [
    aws_iam_user.engine.name,
    aws_iam_user.ci.name
  ]
 
  group = aws_iam_group.group1.name
}
 
resource "aws_iam_access_key" "engine" {
  provider = aws.account_a
 
  user = aws_iam_user.engine.name
}
 
resource "aws_iam_access_key" "ci" {
  provider = aws.account_a
 
  user = aws_iam_user.ci.name
}
 
 
# ============================================================
# GROUP 2
# ============================================================
 
resource "aws_iam_group" "group2" {
  provider = aws.account_a
 
  name = "group2"
}
 
resource "aws_iam_user" "group2_users" {
  provider = aws.account_a
 
  for_each = toset(var.group2_users)
 
  name = each.value
}
 
resource "aws_iam_user_group_membership" "group2_membership" {
  provider = aws.account_a
 
  name = "group2-membership"
 
  users = [
    for user in aws_iam_user.group2_users : user.name
  ]
 
  group = aws_iam_group.group2.name
}
 
resource "aws_iam_access_key" "group2_users" {
  provider = aws.account_a
 
  for_each = aws_iam_user.group2_users
 
  user = each.value.name
}
 
resource "aws_iam_user_login_profile" "group2_users" {
  provider = aws.account_a
 
  for_each = aws_iam_user.group2_users
 
  user = each.value.name
 
  password = var.group2_password
 
  password_reset_required = true
}
 
 
# ============================================================
# ROLE A
# ============================================================
 
data "aws_iam_policy_document" "role_a_trust" {
  provider = aws.account_a
 
  statement {
    effect = "Allow"
 
    principals {
      type = "AWS"
 
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.account_a.account_id}:root"
      ]
    }
 
    actions = [
      "sts:AssumeRole"
    ]
  }
}
 
data "aws_iam_policy_document" "role_a_policy" {
  provider = aws.account_a
 
  statement {
    sid    = "AllowEverythingExceptIAM"
    effect = "Allow"
 
    not_actions = [
      "iam:*"
    ]
 
    resources = [
      "*"
    ]
  }
 
  statement {
    sid    = "ExplicitDenyIAM"
    effect = "Deny"
 
    actions = [
      "iam:*"
    ]
 
    resources = [
      "*"
    ]
  }
}
 
resource "aws_iam_role" "role_a" {
  provider = aws.account_a
 
  name = "roleA"
 
  assume_role_policy = data.aws_iam_policy_document.role_a_trust.json
}
 
resource "aws_iam_policy" "role_a_policy" {
  provider = aws.account_a
 
  name = "RoleA-AdminExceptIAM"
 
  policy = data.aws_iam_policy_document.role_a_policy.json
}
 
resource "aws_iam_role_policy_attachment" "role_a_policy" {
  provider = aws.account_a
 
  role = aws_iam_role.role_a.name
 
  policy_arn = aws_iam_policy.role_a_policy.arn
}
 
 
# ============================================================
# ROLE B
# ============================================================
 
data "aws_iam_policy_document" "role_b_trust" {
  provider = aws.account_a
 
  statement {
    effect = "Allow"
 
    principals {
      type = "AWS"
 
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.account_a.account_id}:root"
      ]
    }
 
    actions = [
      "sts:AssumeRole"
    ]
  }
}
 
resource "aws_iam_role" "role_b" {
  provider = aws.account_a
 
  name = "roleB"
 
  assume_role_policy = data.aws_iam_policy_document.role_b_trust.json
}
 
 
# ============================================================
# ROLE C
# ============================================================
 
data "aws_iam_policy_document" "role_c_trust" {
  provider = aws.account_b
 
  statement {
    sid    = "TrustRoleBOnly"
    effect = "Allow"
 
    principals {
      type = "AWS"
 
      identifiers = [
        aws_iam_role.role_b.arn
      ]
    }
 
    actions = [
      "sts:AssumeRole"
    ]
  }
}
 
resource "aws_iam_role" "role_c" {
  provider = aws.account_b
 
  name = "roleC"
 
  assume_role_policy = data.aws_iam_policy_document.role_c_trust.json
}
 
 
# ============================================================
# ROLE B -> ROLE C PERMISSION
# ============================================================
 
data "aws_iam_policy_document" "role_b_policy" {
  provider = aws.account_a
 
  statement {
    sid    = "AssumeRoleCOnly"
    effect = "Allow"
 
    actions = [
      "sts:AssumeRole"
    ]
 
    resources = [
      aws_iam_role.role_c.arn
    ]
  }
}
 
resource "aws_iam_role_policy" "role_b_policy" {
  provider = aws.account_a
 
  name = "AssumeRoleCOnly"
 
  role = aws_iam_role.role_b.id
 
  policy = data.aws_iam_policy_document.role_b_policy.json
}
 
 
# ============================================================
# ROLE C -> S3
# ============================================================
 
data "aws_iam_policy_document" "role_c_s3_policy" {
  provider = aws.account_b
 
  statement {
    sid    = "BucketLevelPermissions"
    effect = "Allow"
 
    actions = [
      "s3:*"
    ]
 
    resources = [
      aws_s3_bucket.target.arn
    ]
  }
 
  statement {
    sid    = "ObjectLevelPermissions"
    effect = "Allow"
 
    actions = [
      "s3:*"
    ]
 
    resources = [
      "${aws_s3_bucket.target.arn}/*"
    ]
  }
}
 
resource "aws_iam_policy" "role_c_s3_policy" {
  provider = aws.account_b
 
  name = "RoleC-SingleBucketFullAccess"
 
  policy = data.aws_iam_policy_document.role_c_s3_policy.json
}
 
resource "aws_iam_role_policy_attachment" "role_c_s3_policy" {
  provider = aws.account_b
 
  role = aws_iam_role.role_c.name
 
  policy_arn = aws_iam_policy.role_c_s3_policy.arn
}
