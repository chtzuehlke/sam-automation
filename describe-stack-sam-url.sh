#!/bin/bash

NAME=$1
STACK_NAME="${NAME}SAM"

aws cloudformation describe-stacks --stack-name $STACK_NAME --query 'Stacks[].Outputs[?OutputKey==`HelloWorldApi`].OutputValue' --output text
