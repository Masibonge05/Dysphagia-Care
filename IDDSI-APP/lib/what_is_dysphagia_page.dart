import 'package:flutter/material.dart';
import 'package:dysphagia_care_app/level_details.dart'; // Corrected import path

class WhatIsDysphagiaPage extends StatelessWidget {
  const WhatIsDysphagiaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF673AB7), // Setting the purple background color
      appBar: CustomGradientAppBar(
        levelText: '', // No level text for this page
        titleText: 'What is Dysphagia',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align children to the start
            crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/Property 1=What dysphagia side menu.png', // Updated image path
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 20), // Spacing between image and text
              const Text(
                'What is\nDysphagia?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30, // Increased font size
                  fontWeight: FontWeight.bold, // Made text bold
                  color: Colors.white, // Changed text color to white
                ),
              ),
              const SizedBox(height: 20),
              // You can add an image or other widgets here later
            ],
          ),
        ),
      ),
    );
  }
} 