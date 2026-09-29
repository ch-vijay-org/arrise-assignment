Added a backend.tf file which can help to store the terraform state file remotely
Pre-requisites:
  We should have a S3 bucket created and versioning and encryption enabled.
  We should have a Dynamodb created for state locking.
  We can use use below commands to migrate local state to remotely
    terraform init -migrate-state
    
## Remote State & Locking

The Terraform state has been migrated from local storage to an S3 backend.

Benefits:
- Centralized state management
- Shared state across team members
- State file versioning and recovery
- Secure encrypted storage

To prevent concurrent modifications, a DynamoDB table is used for state locking.

Without locking:
- Multiple users can apply changes simultaneously.
- State corruption or infrastructure conflicts may occur.

With DynamoDB locking:
- Only one Terraform operation can modify the state at a time.
- Additional users receive a lock error and must wait until the lock is released.
- Prevents race conditions and protects infrastructure consistency.
