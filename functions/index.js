const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

/*

Basel

We'll create an API endpoint to accept incoming images and put them
in the firebase storage and then we'll return links to these images
so that we can then store these links in the database and use them
when we fetch our data from the database for displaying the images.

*/
