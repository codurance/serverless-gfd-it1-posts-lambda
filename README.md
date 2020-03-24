

serverless-gfd-it1-posts-database
serverless-gfd-it1-posts-lambda
serverless-gfd-it1-api-gateway


Reproducibilidad
================
crear base de datos dynamodb con el naming de arriba
y poner contenido:

Id - 1234  message - value from db

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



