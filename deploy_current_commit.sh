#!/bin/bash

aws s3 rm s3://serverless-spike-dplyfrntnd-a-s3-1 --recursive 
aws s3 rb s3://serverless-spike-dplyfrntnd-a-s3-1  
aws s3api create-bucket --bucket serverless-spike-dplyfrntnd-a-s3-1 --region us-east-1  

cd serverless-spike-dplyfrntnd-a-s3-1 
yarn install
yarn build 
cd ..

aws s3 cp ./serverless-spike-dplyfrntnd-a-s3-1/build s3://serverless-spike-dplyfrntnd-a-s3-1 --recursive  
aws s3api put-bucket-policy --bucket serverless-spike-dplyfrntnd-a-s3-1 --policy file://web-policy.json  
aws s3api put-bucket-cors --bucket serverless-spike-dplyfrntnd-a-s3-1 --cors-configuration file://cors-policy.json  
open https://serverless-spike-dplyfrntnd-a-s3-1.s3.amazonaws.com/index.html
aws s3 sync serverless-spike-dplyfrntnd-a-s3-1/build s3://serverless-spike-dplyfrntnd-a-s3-1/  --cache-control max-age=1
