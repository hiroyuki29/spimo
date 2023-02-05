import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

exports.deleteUser = functions.region("asia-northeast2")
    .firestore.document("deletedUsers/{docId}")
    .onCreate(async (snap, context)=>{
      const deletedDocument = snap.data();
      const userId = deletedDocument.userId;
      await admin.auth().deleteUser(userId);
    });
