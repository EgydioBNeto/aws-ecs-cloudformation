#!/bin/bash

echo "Deploying egydio Infrastructure..."

# 1. Deploy VPC
echo "1. Deploying VPC..."
aws cloudformation deploy --template-file ./network/vpc.yaml --stack-name egydio-prod-vpc --capabilities CAPABILITY_IAM
echo "VPC deployment complete."

# 2. Deploy ALB
echo "2. Deploying ALB..."
aws cloudformation deploy --template-file ./network/alb.yaml --stack-name egydio-prod-alb --capabilities CAPABILITY_IAM
echo "ALB deployment complete."

# 3. Deploy ECR
echo "3. Deploying ECR..."
aws cloudformation deploy --template-file ./ci-cd/ecr.yaml --stack-name egydio-prod-ecr --capabilities CAPABILITY_IAM
echo "ECR deployment complete."

# 4. Deploy ECS Cluster
echo "4. Deploying ECS Cluster..."
aws cloudformation deploy --template-file ./cluster/ecs.yaml --stack-name egydio-prod-ecs --capabilities CAPABILITY_IAM
echo "ECS Cluster deployment complete."

# 5. Deploy ECS Service
echo "5. Deploying ECS Service..."
aws cloudformation deploy --template-file ./cluster/ecs-service.yaml --stack-name egydio-prod-ecs-service --capabilities CAPABILITY_IAM
echo "ECS Service deployment complete."

# 6. Deploy CI/CD Pipeline
echo "6. Deploying CI/CD Pipeline..."
aws cloudformation deploy --template-file ./ci-cd/pipeline.yaml --stack-name egydio-prod-pipeline --capabilities CAPABILITY_IAM
echo "CI/CD Pipeline deployment complete."

echo "egydio Infrastructure deployment is complete!"
