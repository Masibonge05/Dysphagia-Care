import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'personal_info.dart';
import 'welcome1.dart';
import 'welcome2.dart';
import 'welcome3.dart';
import 'welcome4.dart';
import 'welcome5.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'forgot_password_page.dart';
import 'testing_page.dart';
import 'chatbot.dart';
import 'framework1.dart'; // Make sure this exports FrameworkPage
import 'search_page.dart';
import 'testing_page2.dart';
import 'level_details.dart';
import 'home_page.dart'; // Add import for HomePage

class IDDSIApp extends StatelessWidget {
  final bool hasSeenWelcome;
  final bool firebaseInitialized;

  const IDDSIApp({
    super.key, 
    required this.hasSeenWelcome,
    this.firebaseInitialized = true,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4C7378),
          primary: const Color(0xFF1F41BB),
        ),
      ),
      // Use AuthenticationWrapper as home instead of initialRoute
      home: AuthenticationWrapper(
        hasSeenWelcome: hasSeenWelcome,
        firebaseInitialized: firebaseInitialized,
      ),
      routes: {
        '/home': (context) => const HomePage(userName: 'User', currentLevel: 3),
        '/personalInfo': (context) => const IDDSIPersonalInfoPage(),
        '/welcome1': (context) => Welcome1(
              onNext: () {
                Navigator.pushNamed(context, '/welcome2');
              },
            ),
        '/welcome2': (context) => Welcome2(
              onNext: () {
                Navigator.pushNamed(context, '/welcome3');
              },
              onPrevious: () {
                Navigator.pushNamed(context, '/welcome1');
              },
            ),
        '/welcome3': (context) => Welcome3(
              onNext: () {
                Navigator.pushNamed(context, '/welcome4');
              },
              onPrevious: () {
                Navigator.pushNamed(context, '/welcome2');
              },
            ),
        '/welcome4': (context) => Welcome4(
              onNext: () {
                Navigator.pushNamed(context, '/welcome5');
              },
              onPrevious: () {
                Navigator.pushNamed(context, '/welcome3');
              },
            ),
        '/welcome5': (context) => Welcome5(
              onNext: () {
                Navigator.pushNamed(context, '/signin');
              },
              onPrevious: () {
                Navigator.pushNamed(context, '/welcome4');
              },
            ),
        '/signin': (context) => const LoginPage(),
        '/login': (context) => const LoginPage(), // Added alias for consistency
        '/register': (context) => const RegisterPage(),
        '/forgotPassword': (context) => const ForgotPasswordPage(),
        '/framework': (context) => const FrameworkPage(),
        '/testing': (context) => const TestingPage(),
        '/chatbot': (context) => const ChatbotPage(),
        '/search': (context) => const SearchPage(),
        '/levelOptions': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return LevelOptionsPage(
            levelNumber: args['levelNumber'],
            levelType: args['levelType'],
            pageTitle: args['pageTitle'],
          );
        },
        '/level0_fluid_testing': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level0_fluid_testingmethods': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level1_fluid_testing': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level1_fluid_testingmethods': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level2_fluid_testing': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level2_fluid_testingmethods': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level3_fluid_testing': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level3_fluid_testingmethods': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level4_fluid_testing': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level4_fluid_testingmethods': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level3_food_testing': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level3_food_testingmethods': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level3_food_foodspecific': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level4_food_testing': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level4_food_testingmethods': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level4_food_foodspecific': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level5_food_testing': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level5_food_testingmethods': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level5_food_foodspecific': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level6_food_testing': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level6_food_testingmethods': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level6_food_foodspecific': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level7_food_testing': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level7_food_testingmethods': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/level7_food_foodspecific': (context) => LevelDetailsPage(
            arguments: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
      },
    );
  }
}

/// Authentication Wrapper - Handles persistent login and routing
class AuthenticationWrapper extends StatelessWidget {
  final bool hasSeenWelcome;
  final bool firebaseInitialized;

  const AuthenticationWrapper({
    super.key, 
    required this.hasSeenWelcome,
    this.firebaseInitialized = true,
  });

  /// Check if user has completed personal info registration
  Future<bool> _hasCompletedPersonalInfo(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        final data = doc.data();
        // Customize these fields based on your personal info requirements
        return data != null &&
            data.containsKey('firstName') &&
            data.containsKey('lastName') &&
            data['firstName'] != null &&
            data['lastName'] != null;
      }
      return false;
    } catch (e) {
      debugPrint('❌ Error checking personal info: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // If Firebase is not initialized, skip authentication and go directly to welcome/login
    if (!firebaseInitialized) {
      debugPrint('⚠️ Firebase not initialized - showing app without authentication');
      // Show a brief message then navigate
      Future.delayed(const Duration(seconds: 1), () {
        if (context.mounted) {
          if (hasSeenWelcome) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Welcome1(
                  onNext: () {
                    Navigator.pushNamed(context, '/welcome2');
                  },
                ),
              ),
            );
          }
        }
      });
      
      return Scaffold(
        backgroundColor: const Color(0xFF1F41BB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 20),
              Text(
                firebaseInitialized 
                  ? 'Connecting...' 
                  : 'Starting app...',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Handle errors - if Firebase isn't working, show login/welcome
        if (snapshot.hasError) {
          debugPrint('❌ Auth stream error: ${snapshot.error}');
          // If there's an error, treat as not signed in
          if (hasSeenWelcome) {
            return const LoginPage();
          } else {
            return Welcome1(
              onNext: () {
                Navigator.pushNamed(context, '/welcome2');
              },
            );
          }
        }

        // Show loading while checking authentication
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF1F41BB),
              ),
            ),
          );
        }

        // User is signed in
        if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;

          return FutureBuilder<bool>(
            future: _hasCompletedPersonalInfo(user.uid),
            builder: (context, personalInfoSnapshot) {
              // Handle errors when checking personal info
              if (personalInfoSnapshot.hasError) {
                debugPrint('❌ Error checking personal info: ${personalInfoSnapshot.error}');
                // On error, assume personal info not complete
                return const IDDSIPersonalInfoPage();
              }

              // Show loading while checking personal info
              if (personalInfoSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF1F41BB),
                    ),
                  ),
                );
              }

              // Check if user has completed personal info
              final hasPersonalInfo = personalInfoSnapshot.data ?? false;

              // Route to appropriate page directly
              if (hasPersonalInfo) {
                // User has personal info - go to home page
                return const HomePage(userName: 'User', currentLevel: 3);
              } else {
                // User needs to complete personal info
                return const IDDSIPersonalInfoPage();
              }
            },
          );
        }

        // User is not signed in - check if they've seen welcome screen
        if (hasSeenWelcome) {
          return const LoginPage();
        } else {
          return Welcome1(
            onNext: () {
              Navigator.pushNamed(context, '/welcome2');
            },
          );
        }
      },
    );
  }
}
