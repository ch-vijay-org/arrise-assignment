There are two separate issues:
  Trust Policy Bug → Wrong principal ARN.
  Permissions Policy Bug → Invalid/overly broad S3 resource definition.
  
Why It's Wrong:
  roleB is an IAM Role, not an IAM User.
Since the trusted principal ARN is incorrect, AWS cannot match the caller with the trusted entity, and the sts:AssumeRole request fails.
