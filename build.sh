#!/bin/bash
set -e
set -o pipefail

instruction()
{
  echo "usage: ./build.sh deploy <stage>"
  echo ""
  echo "stage: eg. dev, staging, prod, ..."
  echo ""
  echo "for example: ./deploy.sh dev"
}

if [ $# -eq 0 ]; then
  instruction
  exit 1
elif [ "$1" = "build" ] && [ $# -eq 1 ]; then
  npm ci
  node build.js
elif [ "$1" = "deploy" ] && [ $# -eq 2 ]; then
  STAGE=$2
  
  MD5=$(md5sum workshop.zip)
  cd terraform
  terraform apply --var "my_name=yancui" --var "file_name=$MD5"
else
  instruction
  exit 1
fi