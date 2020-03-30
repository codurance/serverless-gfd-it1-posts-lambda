

Naming
========

serverless-gfd-it1-posts-database
serverless-gfd-it1-posts-lambda
serverless-gfd-it1-api-gateway
serverless-frontend-a-s3



Features
=========

c1b2ee9 Lambda endpoint is reachable from internet
fe8e667 Framework: rudimantary e2e testing for lambda 
0bc00ca Lambda works in local
039eec5 Lambda do get value from db with harcoded key
67a8003 Frontend can be deployed seamlessly (automated+idempotent)
  37afe03 do create bucket 
  fb1804e do fill bucket with folder
  f0ab29f do delete bucket
  65f185c do bucket public
  0112d41 do enable CORS api calls
  0fc9dd7 frontend do run in local
  6fcbbe8 do work in new/fresh machine work for all internet
  c34e7fb do disable cache of s3
c5655f2 do fix project react flacky App.js
2595d60 do fix openchat_webclient git ignoring a necesary file
5096a62 disable AWS pager in deployment script
8982150 do login on frontend with fake impl seamlesly (user stub)
1cc274a do fix missuse of Router in openchat_webclient 
d4a537e now can test local env (offline apigateway+lambda)
682de05 Documented how to avoid SSL problems
ed58c10 do work in production 

Reproducibilidad
================
## Previo
npm install aws-sdk (si estas en local)
npm install serverless-offline --save-dev
crear base de datos dynamodb con el naming de arribay poner contenido via el siguiente comando:

aws dynamodb put-item \
    --table-name serverless-gfd-it1-posts-database \
    --item '{
      "id": {"S": "1234"}, "posts": { "L": [    { "M" : {        "dateTime" : { "N" : "1549312452000" },        "postId" : { "S" : "102030" },        "text" : { "S" : "Fake post done via CLI while backend is under construction" },        "userId" : { "S" : "1234" }      }    },    { "M" : {        "dateTime" : { "N" : "1549312453000" },        "postId" : { "S" : "102031" },        "text" : { "S" : "Fake post from another user while backend is under construction" },        "userId" : { "S" : "1234" }      }    }  ] }
    }'

modificar el serverless yml para aputar al arn de la base de datos nueva

'''
      Resource:
        - "arn:aws:dynamodb:us-east-1:300563897675:table/serverless-gfd-it1-posts-database"
'''	

## Local

cd serverless-frontend-a-s3
yarn install
yarn start

En otra terminal:
serverless offline -H certs  --httpPort 3001
añadir certificados a chrome y/o entrar directamente via chrome al endpoint  https://localhost:3001/dev/message y apretar ignore security

### Single invoke in local

serverless invoke local --function hello 

## Demo in Prodction

'''serverless deploy'''
modificar el endpoint generado por el deploy en el test.bash
modificar el endpoint generado por el deploy en el Posts.js


Tests of the prototype
=======================
y los tests deberian passar 

'''
bash test.bash && git add -A && git commit && git push
'''

DoD
===
Poder hacer un get de un tweet de los posts la database por id 
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
Resultado:
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
- hacer que el script de deployment no tenga fatatal error en su ejecucion inicial porque ese error no es critico
- renaming de messages/ endpoint to posts/ endpoint para alinearse con la "kata"
- renaming de "hello" handler.js por "posts"






