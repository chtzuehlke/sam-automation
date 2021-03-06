#!/bin/bash

NAME=$1
REPO_STACK_NAME="${NAME}Code"
STACK_NAME=$NAME

CODE_COMMIT_ARN=$(aws cloudformation describe-stacks --stack-name $REPO_STACK_NAME --query 'Stacks[].Outputs[?OutputKey==`CodeCommitRepositoryARN`].OutputValue' --output text)
CODE_COMMIT_NAME=$(aws cloudformation describe-stacks --stack-name $REPO_STACK_NAME --query 'Stacks[].Outputs[?OutputKey==`CodeCommitRepositoryName`].OutputValue' --output text)

aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://./sam-ci-cd.yaml --capabilities CAPABILITY_IAM --parameters \
    ParameterKey=CodeCommitRepositoryARN,ParameterValue="$CODE_COMMIT_ARN" \
    ParameterKey=CodeCommitRepositoryName,ParameterValue="$CODE_COMMIT_NAME"
