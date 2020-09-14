const functions = require('firebase-functions');

exports.myFunction = functions.firestore
    .document('chat/{message}')
    .onWrite((snapshot, context) => { 
        console.log(snapshot.data());
        return;
     });