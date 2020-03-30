#!/bin/bash
export AWS_PAGER=""

aws s3 rm s3://serverless-frontend-a-s3-3 --recursive 
aws s3 rb s3://serverless-frontend-a-s3-3  
aws s3api create-bucket --bucket serverless-frontend-a-s3-3 --region us-east-1  

cd serverless-frontend-a-s3-3 
pwd
yarn install
yarn build 
cd ..

aws s3 cp ./serverless-frontend-a-s3-3/build s3://serverless-frontend-a-s3-3 --recursive  
aws s3api put-bucket-policy --bucket serverless-frontend-a-s3-3 --policy file://web-policy.json  
aws s3api put-bucket-cors --bucket serverless-frontend-a-s3-3 --cors-configuration file://cors-policy.json  
open https://serverless-frontend-a-s3-3.s3.amazonaws.com/index.html
aws s3 sync serverless-frontend-a-s3-3/build s3://serverless-frontend-a-s3-3/  --cache-control max-age=1
