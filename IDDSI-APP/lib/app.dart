import 'package:flutter/material.dart';
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
      initialRoute: hasSeenWelcome ? '/signin' : '/welcome1',
      routes: {
        '/': (context) => const HomePage(userName: 'User', currentLevel: 3), // CHANGED: Now points to HomePage instead of IDDSIPersonalInfoPage
        '/home': (context) => const HomePage(userName: 'User', currentLevel: 3), // Added explicit home route
        '/personalInfo': (context) => const IDDSIPersonalInfoPage(), // Moved personal info to its own route
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
        '/register': (context) => const RegisterPage(),
        '/forgotPassword': (context) => const ForgotPasswordPage(),
        '/framework': (context) => const FrameworkPage(), // FIXED: Changed from IDDSIFramework() to FrameworkPage()
        '/testing': (context) => const TestingPage(),
        '/chatbot': (context) => const ChatbotPage(),
        '/search': (context) => const SearchPage(), // Also added const for consistency
        '/levelOptions': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return LevelOptionsPage(
            levelNumber: args['levelNumber'],
            levelType: args['levelType'],
            pageTitle: args['pageTitle'],
          );
        },
        '/level0_fluid_testing': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level0_fluid_testingmethods': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level1_fluid_testing': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level1_fluid_testingmethods': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level2_fluid_testing': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level2_fluid_testingmethods': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level3_fluid_testing': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level3_fluid_testingmethods': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level4_fluid_testing': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level4_fluid_testingmethods': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level3_food_testing': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level3_food_testingmethods': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level3_food_foodspecific': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level4_food_testing': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level4_food_testingmethods': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level4_food_foodspecific': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level5_food_testing': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level5_food_testingmethods': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level5_food_foodspecific': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level6_food_testing': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level6_food_testingmethods': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level6_food_foodspecific': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level7_food_testing': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level7_food_testingmethods': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/level7_food_foodspecific': (context) => LevelDetailsPage(arguments: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
      },
    );
  }
}