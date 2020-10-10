import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
const dateformat = require('dateformat');

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
admin.initializeApp();
const db = admin.firestore();
const fcm = admin.messaging();

export const sendToDevice = functions.firestore
.document('appointments/{appointmentId}')
.onCreate(async snapshot => {
    let user = "";
    let time = "";
    const appointment = snapshot.data();
    const querySnapshot = await db
    .collection('doctors')
    .doc(appointment.doctorId)
    .collection('tokens')
    .get();
    const querySnapshotUser = await db.
    collection('users')
    .doc(appointment.userId)
    .get();
    const userName = querySnapshotUser.data();
    if(userName){
        user = userName['name'];
    }
    else{
        user = "someUser";
    }
    time = dateformat(appointment.time.toDate(), 'dddd, mmmm dS');
    const tokens = querySnapshot.docs.map(snap => snap.id);
    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: `Request from ${user}!`,
            body: `Request for booking on ${time}`,
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    }
    return fcm.sendToDevice(tokens, payload);
})