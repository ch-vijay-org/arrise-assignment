Added a backend.tf file which can help to store the terraform state file remotely
Pre-requisites:
  We should have a S3 bucket created and versioning and encryption enabled.
  We should have a Dynamodb created for state locking.
  We can use use below commands to migrate local state to remotely
    terraform init -migrate-state
Current Situation (As both use separate local state files:
  Scenario 1: State Drift
    Engineer A creates a new EC2 instance.
    Engineer B's local state does not know about that change.
    Engineer B applies using outdated state.
    Terraform may attempt to recreate or modify resources unexpectedly.
Scenario 2: Lost Updates
    Both engineers make changes.
    Each local state file diverges.
    Whoever applies last effectively overwrites the "source of truth."
Scenario 3: Resource Conflicts
  Engineer A -> adds EC2 instance
  Engineer B -> changes volume size

Remote backend:
  Everyone uses the same centralized state file.
  Benefits:
    Single source of truth
    State shared across teams
    Easy recovery using S3 versioning
    Supports CI/CD pipelines
DynamoDB:
Terraform creates a lock record in DynamoDB.
  LockID = ec2/dev/terraform.tfstate
  Status = LOCKED
  Owner = Engineer A
  
  Now If  Engineer B runs "terraform apply":
    Error acquiring the state lock
    Engineer B's deployment is blocked until Engineer A finishes.
    After Engineer A completes lock will be released
    Engineer B can then safely run:
  
