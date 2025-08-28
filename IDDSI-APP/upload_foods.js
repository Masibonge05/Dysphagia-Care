const admin = require("firebase-admin");
const fs = require("fs");

// Load your service account key JSON
const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

// Load food data
const foodData = JSON.parse(fs.readFileSync("foods.json"));

// Configuration for notifications
const NOTIFICATION_CONFIG = {
  // Option 1: Send to all users (recommended)
  sendToAllUsers: true,
  
  // Option 2: Send only to users with specific preferences
  filterByPreferences: false,
  preferenceFilters: {
    // Only send to users who enabled push notifications
    pushEnabled: true,
    // Only send to users who enabled email notifications  
    emailEnabled: true,
    // Only send to users in specific food categories
    foodCategories: ["food"], // ["food", "fluid"] or leave empty for all
    // Only send to users with specific food levels
    foodLevels: [], // ["3", "4", "5"] or leave empty for all
  },
  
  // Option 3: Send to specific user IDs only (if you want to override auto-fetch)
  useSpecificUsers: false,
  specificUsers: [
    // "EV0eMQca07QopNg9ENo7Kk4qzRF3", // Example - will be ignored if useSpecificUsers is false
  ],
  
  // Option 4: Exclude certain users
  excludeUsers: [
    // "userId1", "userId2" // Users to exclude from notifications
  ]
};

async function getAllUserIds() {
  try {
    console.log("📊 Fetching users from Firestore...");
    const usersSnapshot = await db.collection("users").get();
    const allUsers = [];
    
    usersSnapshot.docs.forEach(doc => {
      const userData = doc.data();
      const userId = doc.id;
      
      // Apply filters if enabled
      if (NOTIFICATION_CONFIG.filterByPreferences) {
        const prefs = userData.notificationPreferences || {};
        
        // Check push notification preference
        if (NOTIFICATION_CONFIG.preferenceFilters.pushEnabled && !prefs.push) {
          console.log(`⏭️  Skipping user ${userData.name || userId}: push notifications disabled`);
          return;
        }
        
        // Check email notification preference
        if (NOTIFICATION_CONFIG.preferenceFilters.emailEnabled && !prefs.email) {
          console.log(`⏭️  Skipping user ${userData.name || userId}: email notifications disabled`);
          return;
        }
        
        // Check food category filter
        if (NOTIFICATION_CONFIG.preferenceFilters.foodCategories.length > 0) {
          const userCategory = userData.selectedCategory;
          if (!NOTIFICATION_CONFIG.preferenceFilters.foodCategories.includes(userCategory)) {
            console.log(`⏭️  Skipping user ${userData.name || userId}: category '${userCategory}' not in filter`);
            return;
          }
        }
        
        // Check food level filter
        if (NOTIFICATION_CONFIG.preferenceFilters.foodLevels.length > 0) {
          const userFoodLevel = userData.foodLevel;
          if (!NOTIFICATION_CONFIG.preferenceFilters.foodLevels.includes(userFoodLevel)) {
            console.log(`⏭️  Skipping user ${userData.name || userId}: food level '${userFoodLevel}' not in filter`);
            return;
          }
        }
      }
      
      // Check if user is in exclude list
      if (NOTIFICATION_CONFIG.excludeUsers.includes(userId)) {
        console.log(`⏭️  Skipping excluded user: ${userData.name || userId}`);
        return;
      }
      
      allUsers.push({
        id: userId,
        name: userData.name || "Unknown",
        email: userData.email || "No email",
        foodLevel: userData.foodLevel || "Not set",
        category: userData.selectedCategory || "Not set"
      });
    });
    
    console.log(`📋 Found ${allUsers.length} eligible users out of ${usersSnapshot.docs.length} total users`);
    
    // Log user details for verification
    allUsers.forEach(user => {
      console.log(`   👤 ${user.name} (${user.email}) - Food Level: ${user.foodLevel}, Category: ${user.category}`);
    });
    
    return allUsers.map(user => user.id);
    
  } catch (error) {
    console.error("❌ Error fetching users:", error);
    return [];
  }
}

async function createNotificationsForUsers(userIds, foodId, foodName, changeType = "added") {
  const batch = db.batch();
  const notifCollection = db.collection("notifications");

  userIds.forEach(userId => {
    const notifRef = notifCollection.doc(); // Auto-generate notification ID
    batch.set(notifRef, {
      userId: userId,           // Required: User who will receive the notification
      foodId: foodId,          // ID of the food item
      foodName: foodName,      // Name of the food item
      changeType: changeType,  // "added", "updated", or "deleted"
      message: `${foodName} was ${changeType}`,
      read: false,             // Required: Mark as unread initially
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  return batch;
}

async function uploadFoods() {
  console.log("🚀 Starting food upload with automatic user detection...");
  
  // Determine which users should receive notifications
  let targetUserIds = [];
  
  if (NOTIFICATION_CONFIG.useSpecificUsers) {
    targetUserIds = NOTIFICATION_CONFIG.specificUsers;
    console.log(`📢 Using manually specified users (${targetUserIds.length} users)`);
  } else if (NOTIFICATION_CONFIG.sendToAllUsers) {
    console.log("📢 Automatically fetching all users from Firebase...");
    targetUserIds = await getAllUserIds();
  }

  if (targetUserIds.length === 0) {
    console.warn("⚠️  No target users found for notifications!");
    console.log("💡 Tips:");
    console.log("   • Check if users exist in your 'users' collection");
    console.log("   • Verify your filter settings in NOTIFICATION_CONFIG");
    console.log("   • Make sure users have the required notification preferences");
    return;
  }

  console.log(`🎯 Will send notifications to ${targetUserIds.length} users`);

  // Create batch for foods
  let batch = db.batch();
  const foodCollection = db.collection("foods");
  let operationCount = 0;
  const maxBatchSize = 400; // Conservative limit to account for notifications

  for (let i = 0; i < foodData.length; i++) {
    const food = foodData[i];
    
    // Add food to batch
    const foodDocRef = foodCollection.doc(); // Auto-generate ID
    batch.set(foodDocRef, food);
    operationCount++;

    // Calculate notification operations needed
    const notificationOps = targetUserIds.length;
    
    if (operationCount + notificationOps > maxBatchSize) {
      // Commit current batch and start a new one
      console.log(`💾 Committing batch (${operationCount} operations)...`);
      await batch.commit();
      batch = db.batch();
      operationCount = 0;
      
      // Re-add the food to the new batch
      batch.set(foodDocRef, food);
      operationCount++;
    }

    // Add notifications to batch
    targetUserIds.forEach(userId => {
      const notifRef = db.collection("notifications").doc();
      batch.set(notifRef, {
        userId: userId,
        foodId: foodDocRef.id,
        foodName: food.name,
        changeType: "added",
        message: `${food.name} was added`,
        read: false,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
      });
      operationCount++;
    });

    console.log(`📝 Processed food ${i + 1}/${foodData.length}: ${food.name} (${targetUserIds.length} notifications)`);
  }

  // Commit final batch
  if (operationCount > 0) {
    console.log(`💾 Committing final batch (${operationCount} operations)...`);
    await batch.commit();
  }

  console.log("✅ All foods and notifications uploaded successfully!");
  console.log(`📊 Summary:`);
  console.log(`   • Foods uploaded: ${foodData.length}`);
  console.log(`   • Users notified: ${targetUserIds.length}`);
  console.log(`   • Total notifications: ${foodData.length * targetUserIds.length}`);
  console.log(`🎉 Users will now see notifications in the app!`);
}

// Enhanced function to update existing food
async function updateFood(foodId, updatedData, notifyAllUsers = true) {
  const batch = db.batch();
  
  // Update food
  const foodRef = db.collection("foods").doc(foodId);
  batch.update(foodRef, {
    ...updatedData,
    updated_at: admin.firestore.FieldValue.serverTimestamp()
  });

  // Get target users
  const targetUsers = notifyAllUsers ? await getAllUserIds() : NOTIFICATION_CONFIG.specificUsers;
  
  targetUsers.forEach(uid => {
    const notifRef = db.collection("notifications").doc();
    batch.set(notifRef, {
      userId: uid,
      foodId: foodId,
      foodName: updatedData.name || "Unknown Food",
      changeType: "updated",
      message: `${updatedData.name || "A food item"} was updated`,
      read: false,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  await batch.commit();
  console.log(`✅ Food updated with notifications sent to ${targetUsers.length} users!`);
}

// Enhanced function to delete food
async function deleteFood(foodId, foodName, notifyAllUsers = true) {
  const batch = db.batch();
  
  // Delete food
  const foodRef = db.collection("foods").doc(foodId);
  batch.delete(foodRef);

  // Get target users
  const targetUsers = notifyAllUsers ? await getAllUserIds() : NOTIFICATION_CONFIG.specificUsers;
  
  targetUsers.forEach(uid => {
    const notifRef = db.collection("notifications").doc();
    batch.set(notifRef, {
      userId: uid,
      foodId: foodId,
      foodName: foodName,
      changeType: "deleted",
      message: `${foodName} was deleted`,
      read: false,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  await batch.commit();
  console.log(`✅ Food deleted with notifications sent to ${targetUsers.length} users!`);
}

// Function to test user fetching (useful for debugging)
async function testUserFetching() {
  console.log("🧪 Testing user fetching...");
  const users = await getAllUserIds();
  console.log(`Found ${users.length} users:`, users);
}

// Run the upload
uploadFoods().catch((err) => console.error("❌ Upload failed:", err));

// Uncomment to test user fetching only:
// testUserFetching().catch((err) => console.error("❌ Test failed:", err));

// Export functions for future use
module.exports = {
  uploadFoods,
  updateFood,
  deleteFood,
  getAllUserIds,
  testUserFetching
};
