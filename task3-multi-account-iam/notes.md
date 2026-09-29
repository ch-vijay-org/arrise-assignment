# Task 3 – Multi-Account IAM & Cross-Account Access
 
## 1. Would you actually give engine and ci IAM users with access keys in a real production setup?
 
No. For a real production setup, I would generally avoid long-lived IAM user access keys.
 
For CI/CD workloads, I would use temporary credentials through an IAM role, preferably using OIDC federation from the CI/CD platform such as GitHub Actions.
 
For human users, I would use AWS IAM Identity Center with federated identities rather than creating individual IAM users with permanent access keys.
 
This provides better security because credentials are temporary, can be centrally managed, and reduce the risk of leaked long-lived access keys.
 
The IAM users and access keys in this Terraform implementation are mainly to satisfy the assignment requirement and demonstrate IAM concepts.
 
---
 
## 2. Why does it matter whether roleC trusts the whole Account A root vs roleB's specific ARN?
 
Trusting the whole Account A means that the trust relationship is established with principals from the entire Account A security boundary, subject to their permissions to perform sts:AssumeRole.
 
Trusting roleB's specific ARN restricts the trust relationship to roleB.
 
In this implementation:
 
Account A
    |
    roleB
    | sts:AssumeRole
           
Account B
    |
    roleC
     |
    Specific S3 bucket
 
Therefore, roleC can only be assumed through roleB rather than directly by other principals in Account A.
 
This follows the principle of least privilege and creates a much narrower cross-account trust relationship.
