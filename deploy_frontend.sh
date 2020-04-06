#!/bin/bash
export AWS_PAGER=""

aws s3 rm s3://serverless-demo-it1-frontend-a-s3 --recursive 
aws s3 rb s3://serverless-demo-it1-frontend-a-s3  
aws s3api create-bucket --bucket serverless-demo-it1-frontend-a-s3 --region us-east-1  

cd serverless-frontend-a-s3 
pwd
yarn install
REACT_APP_API_URL="https://zmt518vd6e.execute-api.us-east-1.amazonaws.com/dev/" yarn build 
cd ..

aws s3 cp ./serverless-frontend-a-s3/build s3://serverless-demo-it1-frontend-a-s3 --recursive  
aws s3api put-bucket-policy --bucket serverless-demo-it1-frontend-a-s3 --policy file://web-policy.json  
aws s3api put-bucket-cors --bucket serverless-demo-it1-frontend-a-s3 --cors-configuration file://cors-policy.json  
aws s3 sync serverless-frontend-a-s3/build s3://serverless-demo-it1-frontend-a-s3/  --cache-control max-age=1
open https://serverless-demo-it1-frontend-a-s3.s3.amazonaws.com/index.html
