import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'app.dart'; // Import your app with routing and logic

// Background message handler must be a top-level function
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('🔔 Handling a background message: ${message.messageId}');
}

// Local notifications plugin instance
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for web and mobile
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyC0ENNhrABPVqFGWRupcJtH5G49rRbqcfo",
          authDomain: "iddsi-app.firebaseapp.com",
          projectId: "iddsi-app",
          storageBucket: "iddsi-app.appspot.com",
          messagingSenderId: "844640842201",
          appId: "1:844640842201:web:903d21c590150b6d5be9c8",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    debugPrint('✅ Firebase initialized successfully');
  } catch (e) {
    debugPrint('❌ Error initializing Firebase: $e');
  }

  // Request permissions for iOS and macOS (mobile only)
  if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Initialize local notifications (mobile only)
  if (!kIsWeb) {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Subscribe to topic for receiving notifications (mobile only)
  if (!kIsWeb) {
    try {
      await FirebaseMessaging.instance.subscribeToTopic('foodUpdates');
      debugPrint('✅ Subscribed to foodUpdates topic');
    } catch (e) {
      debugPrint('❌ Error subscribing to topic: $e');
    }
  } else {
    debugPrint('ℹ️ Web platform - skipping topic subscription');
  }

  // Listen for foreground messages to show local notifications (mobile only)
  if (!kIsWeb) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'iddsi_channel', // channel ID
              'IDDSI Notifications', // channel name
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  // Get and print the FCM token
  String? token;
  if (!kIsWeb) {
    try {
      token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        debugPrint('📲 FCM Token: $token');
      }
    } catch (e) {
      debugPrint('❌ Error getting FCM token: $e');
    }
  } else {
    // For web, you'll need a VAPID key to get FCM token
    // Uncomment and add your VAPID key if you need web push notifications
    // try {
    //   token = await FirebaseMessaging.instance.getToken(vapidKey: 'your-vapid-key');
    //   if (token != null) {
    //     debugPrint('📲 Web FCM Token: $token');
    //   }
    // } catch (e) {
    //   debugPrint('❌ Error getting web FCM token: $e');
    // }
    debugPrint('ℹ️ Web platform - FCM token requires VAPID key');
  }

  // Load if user has seen welcome screen before
  final prefs = await SharedPreferences.getInstance();
  final hasSeenWelcome = prefs.getBool('hasSeenWelcome') ?? false;

  runApp(IDDSIApp(hasSeenWelcome: hasSeenWelcome));
}