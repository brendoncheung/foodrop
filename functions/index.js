const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

//! You deploy your functions using this CLI command: firebase deploy --only functions

// http request 1

// http trigger - this is a endpoint request, kinda like endpoint for api
// after you deployed your functions, you will get this endpoint on your function console: https://us-central1-foodrop-a41e7.cloudfunctions.net/randomNumber
exports.randomNumber = functions.https.onRequest((request, response) => {
    const number = Math.round(Math.random() * 100);
    response.send(number.toString);
});

// introduction to cloud functions: https://www.youtube.com/watch?v=d9GrysWH1Lc
// difference between http endpoint and callable https://medium.com/@topeomot/why-you-should-be-using-firebase-http-callable-functions-a96c328f0600


exports.addClientRole = functions.https.onCall((data, context) => {

    
    functions.logger.log("addClientRole incoming data", data);
    return admin.auth().setCustomUserClaims(data.uid, {
        client: true
    })
})

// http callable

exports.sayHello = functions.https.onCall((data, context) => {
    functions.logger.log("the context obj", data)
})