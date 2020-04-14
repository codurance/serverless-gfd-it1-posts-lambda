Instructions
============
- Clone the following [repository](https://github.com/codurance/serverless-base) which will give you access to a fully aws-serverless enabled container
- Clone the following [repository](frontendrepo). This will be the frontend project
- Add the frontend project as a volume to your container. If the project is called `lambda-training`, then you can add the volume like this
  - Edit `docker-compose.yml`file and add
  - ```
    ...
    
    ./serverless:/home/svrless
    $PATH_TO_YOUR_FOLDER/lambda-training:/home/lambda-training
    
    ...

    ``` 
- Access your docker container by running
  - `cd YOUR_AWS_SERVERLESS_CONTAINER_REPO`
  - `docker-compose build`
  - `docker-compose up -d `
  - `docker exec -it serverless-image_serverless-framework_1 /bin/bash` Where `serverless-image_serverless-framework_1` is the name of your container. You can get the name by running `docker-compose ps`
  
  Once there, you'll get something like this
  ```
  root@ec5fe463cbb6:/home/svrless#
  ```

  Now you have access to your container. You can move to `/home/lambda-training` and perform everything from that folder


## Creating your first lambda service

### Credentials
In order to create your first lambda service, you need to get your AWS credentials. To do so, first go to your **AWS** console -> **My Security Credentials**. Once there, go to **AWS IAM credentials** tab, then look for the section **Access keys for CLI, SDK, & API Access**, click on **Create access key** and save those values. Once you leave the area, you won't be able to see those values again, so make sure to take note of them.

Once done with that, you'll end up with 2 values, an `Access Key ID` and a `Secret access key` which you'll need for the next step


### Setting up Serverless Framework
Run 

`serverless config credentials --provider aws --key KEY --secret SECRET` with values obtained from the previous step. This will set your serverless environment as well as **AWS CLI** with your credentials

### Creating your first Lambda Function
You can simply run 

`serverless create --template aws-nodejs --name my-service --path my-service`.

This will create a sample Lambda function called `my-service` inside a `my-service` folder, based on **NodeJS** which you can change and configure later. You can specify other types like, as mentioned in the [docs](https://serverless.com/framework/docs/providers/aws/cli-reference/create/). Of course, you can change `my-service` with the name you prefer

### Code your first Lambda
In order to achieve that, go to your recently created Lambda function `my-service`  folder (or the name you entered). There you'll see 2 files, one `serverless.yml` file, as well as a `handler.js` file (this, based on the NodeJS setup. It will vary if you use other templates).

Open your `serverless.yml` file, locate the `events` section and remove comments from there, `http`, `path` and `method`. The result should look like this

```
    events:
      - http:
          path: users/create
          method: get
```

Replace `users/create` with your preferred path. After that, you can delete all other commented lines

### Deploy
In order to deploy the recently created simply execute
`serverless deploy`

Once finished, you'll be presented with a screen that summarizes your deployment and the available endpoint.

**Congratulations on your creating and deploying your first Lambda!!** 


Naming
========

- serverless-gfd-it1-posts-database
- serverless-gfd-it1-posts-lambda
- serverless-gfd-it1-api-gateway
- serverless-frontend-a-s3



Features
=========

- X->setup one-timers

  Docker image:
- X 6f47204 Docker, base image for serverless development. 
- X 0e40438 Added docker-compose 
- X 7ae7abe Added docker-compose volume binding fixed
- X 3a3bf05 Added more AWS stack
- X f4b7a2a Added yarn upgrade
-   Application:
-   c1b2ee9 Lambda endpoint is reachable from internet
-   fe8e667 rudimantary e2e testing for lambda 
- X 0bc00ca Lambda works in local
-   039eec5 Lambda do get value from db with harcoded key
- X  67a8003 Frontend can be deployed seamlessly (automated+idempotent)
- X  37afe03 do create bucket 
- X  fb1804e do fill bucket with folder
- X  f0ab29f do delete bucket
- X  65f185c do bucket public
- X  0112d41 do enable CORS api calls
- X  0fc9dd7 frontend do run in local
- X  6fcbbe8 do work in new/fresh machine work for all internet
- X  c34e7fb do disable cache of s3
- X  c5655f2 do fix project react flacky App.js
- X  2595d60 do fix openchat_webclient git ignoring a necesary file
- X  5096a62 disable AWS pager in deployment script
-    8982150 do login on frontend with fake impl seamlesly (user stub)
- X  cc274a do fix missuse of Router in openchat_webclient 
- X d4a537e now can test local env (offline apigateway+lambda)
- X 682de05 Documented how to avoid SSL problems
- X ed58c10 do work in production 

Reproducibilidad
================
## Previo
- npm install aws-sdk (si estas en local)
- npm install serverless-offline --save-dev
- crear base de datos dynamodb con el naming de arribay poner contenido via el siguiente comando:


``` 
aws dynamodb put-item \
    --table-name serverless-gfd-it1-posts-database \
    --item '{
      "id": {"S": "1234"}, "posts": { "L": [    { "M" : {        "dateTime" : { "N" : "1549312452000" },        "postId" : { "S" : "102030" },        "text" : { "S" : "Fake post done via CLI while backend is under construction" },        "userId" : { "S" : "1234" }      }    },    { "M" : {        "dateTime" : { "N" : "1549312453000" },        "postId" : { "S" : "102031" },        "text" : { "S" : "Fake post from another user while backend is under construction" },        "userId" : { "S" : "1234" }      }    }  ] }
    }'

``` 


modificar el serverless yml para aputar al arn de la base de datos nueva

```
      Resource:
        - "arn:aws:dynamodb:us-east-1:300563897675:table/serverless-gfd-it1-posts-database"
```	

## Local

`cd serverless-frontend-a-s3`
`yarn install`
`yarn start`

En otra terminal:
`serverless offline -H certs  --httpPort 3001`
añadir certificados a chrome y/o entrar directamente via chrome al endpoint  https://localhost:3001/dev/message y apretar ignore security

### Single invoke in local

`serverless invoke local --function hello `

## Demo in Prodction

`serverless deploy`
modificar el endpoint generado por el deploy en el test.bash
modificar el endpoint generado por el deploy en el Posts.js

## Reset the production infra set up 
`serverless remove -v`
`serverless deploy`

Tests of the prototype
=======================
y los tests deberian passar 

```
bash test.bash && git add -A && git commit && git push
```

DoD
===
Poder hacer un get de los posts por usuario de la database por id 
Los posts propios de un usuario se llama timeline
Para ello, hacer login con cualquier nombre o password y entrar en timeline
Deployarlo todo en un solo script

Foco
=====
### Detectar implicit resources needed
Resultado:
- IAM Roles
- install aws sdk

### Cronometrar
Resultado: (temporal, de la primera parte)
- 45 mins all environent (GIT) 
- without git 15 mins for hello world
- 1:10 para (db creation, db usage, local testing)
- 25 mins without not having knowledge

### Investigar el serverless framework
Resultado:
- simulacion en local de una sola invocacion y levantar la lambda para localhost 

### Sacar una solucion en in infra as code o via cli commands
Resultado:
- esta demostrado que es asequible de setupear via script 
- terraform pero parece la manera que se usaria en la realidad

### Fake del frontend (fake de autenticacion y fake de get wall) sea lo mas entendible possible 
- todo el faking se ha hecho programaticamente y en vanilla js


## Iteracion 2
To consider on following iterations
==================================
- do a terraform spike to substitute script
- update docker image with Reproducibilidad steps
- make it run in production (enable CORS in lambdas)
- V - make production lambda work
- hacer que el script de deployment no tenga fatatal error en su ejecucion inicial porque ese error no es critico
- renaming de messages/ endpoint to posts/ endpoint para alinearse con la "kata"
- renaming de "hello" handler.js por "posts"
- make use of stages to differentiate production from development
- make use of variables in deployment script
- Create a script that removes any resource by looking at the name of the resources ex. "serverless-gfd*"





