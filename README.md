

serverless-gfd-it1-posts-database
serverless-gfd-it1-posts-lambda
serverless-gfd-it1-api-gateway


Reproducibilidad
================
crear base de datos dynamodb con el naming de arriba
y poner contenido:

Id - 1234  posts - [    { "M" : {        "dateTime" : { "N" : "1549312452000" },        "postId" : { "S" : "102030" },        "text" : { "S" : "Fake post while backend is under construction" },        "userId" : { "S" : "1234" }      }    },    { "M" : {        "dateTime" : { "N" : "1549312453000" },        "postId" : { "S" : "102031" },        "text" : { "S" : "Fake post from another user while backend is under construction" },        "userId" : { "S" : "1234" }      }    }  ]

(todos strings)

modificar el serverless yml para aputar al arn de la base de datos nueva

'''
      Resource:
        - "arn:aws:dynamodb:us-east-1:300563897675:table/serverless-gfd-it1-posts-database"
'''	


y luego correr 

'''serverless deploy'''

modificar el endpoint generado por el deploy en el test.bash


y los tests deberian passar 

'''
bash test.bash && git add -A && git commit && git push
'''


DoD
===
poder hacer un get de un tweet de la database por id 

Foco
=====
Detectar implicit resources needed
- IAM Roles
- install aws sdk

Cronometrar
- 45 mins all environent (GIT) 
- without git 15 mins for hello world
- 1:10 para (db creation, db usage, local testing)
- 25 mins without not having knowledge

Investigar el serverless framework
- simulacion en local 

'''
serverless invoke local --function hello 
'''

- indicar stages 
'''
serverless deploy --stage production
'''

Sacar una solucion en in infra as code
- PENDIENTE
- es asequible de setupear via script 
- ignoramos que hacer con el api gateway


To consider on following iterations
==================================
- how to deploy 2 lamnbdas with the same api gateway

1 it
=====
Lambda en serverless que retorna el tweet hardcodeado

2 it 
=====
Do A/B testing with stages




## Iteracion 2


serverless-frontend-a-s3


Reproducibilidad
================


DoD
===
Poder ver los posts en el frontend sin hacer login i con un fake get-wall
Deployarlo todo en un solo script

Foco
=====
Hacerlo rapido 40min
Fake del frontend (fake de autenticacion y fake de get wall) sea lo mas entendible possible 


To consider on following iterations
==================================
- hacer que el script de deployment no tenga fatatal error en su ejecucion inicial





