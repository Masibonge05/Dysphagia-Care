import 'package:flutter/material.dart';
import 'welcome1.dart';

void main() {
  runApp(const SimpleIDDSIApp());
}

class SimpleIDDSIApp extends StatelessWidget {
  const SimpleIDDSIApp({super.key});

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
      home: Welcome1(
        onNext: () {
          // Navigation will be added later
        },
      ),
    );
  }
}

