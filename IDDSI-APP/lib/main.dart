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

  // Initialize Firebase for web and mobile with timeout
  bool firebaseInitialized = false;
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
      ).timeout(
        const Duration(seconds: 3),
        onTimeout: () {
          debugPrint('⚠️ Firebase initialization timed out - continuing without Firebase');
          throw Exception('Firebase initialization timeout');
        },
      );
    } else {
      await Firebase.initializeApp().timeout(
        const Duration(seconds: 3),
        onTimeout: () {
          debugPrint('⚠️ Firebase initialization timed out - continuing without Firebase');
          throw Exception('Firebase initialization timeout');
        },
      );
    }
    firebaseInitialized = true;
    debugPrint('✅ Firebase initialized successfully');
  } catch (e) {
    debugPrint('❌ Error initializing Firebase: $e - App will continue without Firebase features');
    firebaseInitialized = false;
    // Continue anyway - the app will handle authentication errors gracefully
  }

  // Only initialize Firebase-dependent features if Firebase initialized successfully
  if (firebaseInitialized) {
    // Request permissions for iOS and macOS (mobile only)
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      try {
        await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
      } catch (e) {
        debugPrint('❌ Error requesting permissions: $e');
      }
    }

    // Initialize local notifications (mobile only)
    if (!kIsWeb) {
      try {
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');

        const InitializationSettings initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
        );

        await flutterLocalNotificationsPlugin.initialize(initializationSettings);

        // Set background message handler
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      } catch (e) {
        debugPrint('❌ Error initializing notifications: $e');
      }
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
      try {
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
      } catch (e) {
        debugPrint('❌ Error setting up message listener: $e');
      }
    }

    // Get and print the FCM token
    if (!kIsWeb) {
      try {
        String? token = await FirebaseMessaging.instance.getToken();
        debugPrint('📲 FCM Token: $token');
      } catch (e) {
        debugPrint('❌ Error getting FCM token: $e');
      }
    } else {
      debugPrint('ℹ️ Web platform - FCM token requires VAPID key');
    }
  } else {
    debugPrint('⚠️ Skipping Firebase-dependent initialization');
  }

  // Load if user has seen welcome screen before
  bool hasSeenWelcome = false;
  try {
    final prefs = await SharedPreferences.getInstance();
    hasSeenWelcome = prefs.getBool('hasSeenWelcome') ?? false;
  } catch (e) {
    debugPrint('❌ Error loading preferences: $e');
    hasSeenWelcome = false;
  }

  debugPrint('🚀 Starting app - hasSeenWelcome: $hasSeenWelcome, firebaseInitialized: $firebaseInitialized');
  
  runApp(IDDSIApp(
    hasSeenWelcome: hasSeenWelcome,
    firebaseInitialized: firebaseInitialized,
  ));
}