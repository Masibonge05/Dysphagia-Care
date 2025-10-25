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

  const IDDSIApp({super.key, required this.hasSeenWelcome});

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
      home: AuthenticationWrapper(hasSeenWelcome: hasSeenWelcome),
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

  const AuthenticationWrapper({super.key, required this.hasSeenWelcome});

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
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
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

              // Route to appropriate page
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (hasPersonalInfo) {
                  // User has personal info - go to home page
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // User needs to complete personal info
                  Navigator.pushReplacementNamed(context, '/personalInfo');
                }
              });

              // Return loading screen while navigation happens
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1F41BB),
                  ),
                ),
              );
            },
          );
        }

        // User is not signed in - check if they've seen welcome screen
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (hasSeenWelcome) {
            Navigator.pushReplacementNamed(context, '/signin');
          } else {
            Navigator.pushReplacementNamed(context, '/welcome1');
          }
        });

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Color(0xFF1F41BB),
            ),
          ),
        );
      },
    );
  }
}
