There are two separate issues:
  Trust Policy Bug → Wrong principal ARN.
  Permissions Policy Bug → Invalid/overly broad S3 resource definition.
  
Why It's Wrong:
  roleB is an IAM Role, not an IAM User.
Since the trusted principal ARN is incorrect, AWS cannot match the caller with the trusted entity, and the sts:AssumeRole request fails.

Issue #2: Permissions Policy:
Why It's Wrong:
  The requirement from Task 3 was:
  roleC should have full access to a single named S3 bucket.

However this policy grants:
  s3:*
  Resource = *

which means:
  All S3 actions
  All S3 buckets
  Entire AWS account scope
This violates least privilege and does not meet the requirement.
