'use strict';

const middy = require('middy')
const { cors } = require('middy/middlewares')

var  handler = async event => {
  var AWS = require('aws-sdk');
  AWS.config.update({ region: 'us-east-1' });
  var parse = AWS.DynamoDB.Converter.output;


  // Create the DynamoDB service object
  var ddb = new AWS.DynamoDB({ apiVersion: '2012-08-10' });

  var params = {
    TableName: 'serverless-gfd-it1-posts-database',
    Key: {
      'id': { S: '1234' }
    },
    ProjectionExpression: 'posts'
  };

  return await new Promise((resolve, reject) => {
    ddb.getItem(params, function (err, data) {
      if (err) {
        console.log("Error", err);
      } else {
        resolve({
          statusCode: 200,
          body: JSON.stringify(
             parse({ "M": data.Item}).posts,
            null,
            2
          ),
        })
      }
    });
  });
};

module.exports.hello = middy(handler).use(cors())