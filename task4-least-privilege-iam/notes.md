Assumptions:

The CI pipeline needs access only to:

ECR Repository: myapp-prod
ECS Cluster: prod-cluster
ECS Service: myapp-service
Task Definition Family: myapp
S3 Artifact Bucket: myapp-build-artifacts

ECR:
The pipeline must:
  Authenticate to ECR.
  Upload image layers.
  Push image tags.

Therefore only the following permissions were granted:
  ecr:GetAuthorizationToken
  ecr:BatchCheckLayerAvailability
  ecr:InitiateLayerUpload
  ecr:UploadLayerPart
  ecr:CompleteLayerUpload
  ecr:PutImage
  
ECS:
The pipeline must:
  Register a new task definition revision.
  Update an existing ECS service to use the new task definition.
  Read deployment status.
Therefore only:
  ecs:RegisterTaskDefinition
  ecs:DescribeTaskDefinition
  ecs:UpdateService
  ecs:DescribeServices
  ecs:DescribeClusters
  
IAM:
ECS task definitions typically reference:
  Task Execution Role
  Application Task Role

The pipeline therefore requires:
  iam:PassRole

S3:
The pipeline only needs to download build artifacts.
Therefore only:
  s3:ListBucket
  s3:GetObject  
