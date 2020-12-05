const functions = require('firebase-functions');
const admin = require('firebase-admin');

//! You deploy your functions using this CLI command: firebase deploy --only functions

// http request 1

// http trigger - this is a endpoint request, kinda like endpoint for api
// after you deployed your functions, you will get this endpoint on your function console: https://us-central1-foodrop-a41e7.cloudfunctions.net/randomNumber
exports.randomNumber = functions.https.onRequest((request, response) => {
    const number = Math.round(Math.random() * 100);
    response.send(number.toString);
});

exports.addClientRole = functions.https.onCall((data, context) => {
    console.print(context)
    return admin.auth().getUserByEmail(data.email).then(user => {
        return admin.auth().setCustomUserClaims(user.uid, {
            client: true
        })
    })
})

// http callable

exports.sayHello = functions.https.onCall((data, context) => {
    functions.logger.log("the context obj", data)
})