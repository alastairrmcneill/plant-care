
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// When a new user is added to a household

exports.addUserToHousehold = functions.firestore
    .document("households/{householdId}")
    .onUpdate(async (snapshot, context) => {
      const newHouseholdData = snapshot.after.data();
      const oldHouseholdData = snapshot.before.data();

      if (newHouseholdData.members.length > oldHouseholdData.members.length) {
        console.log("New member joined household");
      }
    });

// When a plant is added to a household

exports.addPlantToHousehold = functions.firestore
    .document("households/{householdId}")
    .onUpdate(async (snapshot, context) => {
      const newHouseholdData = snapshot.after.data();
      const oldHouseholdData = snapshot.before.data();

      if (newHouseholdData.plants.length >
        oldHouseholdData.plants.length) {
        console.log("New plant added");
      }
    });

// Check next action date
exports.scheduledFunction = functions.pubsub.
    schedule("every 2 minutes").onRun(async () => {
      const nowTimestamp = Date.now();
      const now = new Date(nowTimestamp);
      const data = await admin.firestore()
          .collection("events")
          .where("nextAction", "<=", now)
          .get();
      data.docs.map(async (event) => {
        const eventData = event.data();
        // Build notification
        console.log(eventData.notificationMessage);
        const payload = {
          notification: {
            title: event.data().notificationMessage,
            body: "",
          },
        };
        const options = {
          priority: "high",
          timeToLive: 60 * 60 * 24,
        };
        // Find who to send to
        const householdId = eventData.householdUid;
        const householdDoc = await admin.firestore()
            .collection("households")
            .doc(householdId)
            .get();
        const householdData = householdDoc.data();
        // Loop through users and send notification

        const memberInfo = householdData.memberInfo;

        if (householdDoc.exists) {
          for (const userId in memberInfo) {
            if (userId !== null) {
              const token = memberInfo[userId].token;
              if (token !== "") {
                console.log(`Send notification to ${token}`);

                admin.messaging().sendToDevice(token, payload, options);
              }
            }
          }
        }
      });
    });
