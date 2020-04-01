#!/bin/bash
export AWS_PAGER=""

aws s3 rm s3://serverless-it2-frontend-a-s3-it1example --recursive 
aws s3 rb s3://serverless-it2-frontend-a-s3-it1example  
aws s3api create-bucket --bucket serverless-it2-frontend-a-s3-it1example --region us-east-1  

cd serverless-frontend-a-s3 
pwd
yarn install
yarn build 
cd ..

aws s3 cp ./serverless-frontend-a-s3/build s3://serverless-it2-frontend-a-s3-it1example --recursive  
aws s3api put-bucket-policy --bucket serverless-it2-frontend-a-s3-it1example --policy file://web-policy.json  
aws s3api put-bucket-cors --bucket serverless-it2-frontend-a-s3-it1example --cors-configuration file://cors-policy.json  
aws s3 sync serverless-frontend-a-s3/build s3://serverless-it2-frontend-a-s3-it1example/  --cache-control max-age=1
open https://serverless-it2-frontend-a-s3-it1example.s3.amazonaws.com/index.html
