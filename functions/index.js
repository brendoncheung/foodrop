const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

//! You deploy your functions using this CLI command: firebase deploy --only functions

// introduction to cloud functions: https://www.youtube.com/watch?v=d9GrysWH1Lc
// difference between http endpoint and callable https://medium.com/@topeomot/why-you-should-be-using-firebase-http-callable-functions-a96c328f0600

exports.addVendorRole = functions.https.onCall((data, context) => {
    if(context.auth.token.vendor !== true) {
        return admin.auth().setCustomUserClaims(data.uid, {
            vendor: true
        })
    } else {
        return;
    }
})

// for background triggers, you must return a value or a promise
// remember the onCreate trigger happens at the very end.

exports.onCreateNewUser = functions.auth.user().onCreate((user) => {
    return;
    functions.logger.log("onCreateNewUser");
    return admin.auth().setCustomUserClaims(user.uid, {
        vendor: false
    })
})
