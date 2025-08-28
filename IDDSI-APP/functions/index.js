const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();

exports.foodChangeTrigger = functions.firestore
  .document("foods/{foodId}")
  .onWrite(async (change, context) => {
    const foodId = context.params.foodId;
    const after = change.after.exists ? change.after.data() : null;
    const before = change.before.exists ? change.before.data() : null;

    let changeType = "added";
    if (!after) changeType = "deleted";
    else if (before) changeType = "updated";

    const foodName = (after && after.name) || (before && before.name) || "Unknown";

    const message = {
      notification: {
        title: "Food update",
        body: `${foodName} was ${changeType}`,
      },
      topic: "foodUpdates", // send to a topic all devices can subscribe to
    };

    // Add notification to Firestore (optional)
    await db.collection("notifications").add({
      foodId,
      foodName,
      changeType,
      message: `${foodName} was ${changeType}`,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Send push notification
    return admin.messaging().send(message);
  });

