import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Assuming CustomGradientAppBar is in level_details.dart or a common file
import 'package:iddsi_app/level_details.dart'; // Corrected import path

class WhatIsIddsiPage extends StatelessWidget {
  const WhatIsIddsiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomGradientAppBar(
        levelText: '', // No level text for this page
        titleText: 'What is the IDDSI?',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png', // Assuming you have a background image
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IDDSI Logo (assuming it's an asset)
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/iddsi-logo.png', // Replace with your actual logo asset path
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Question icon and text
                   Row(
                     children: [
                        // Assuming you have an icon asset for the question mark/person
                       SvgPicture.asset(
                         'assets/icons/Vector (2).png', // Replace with your actual icon asset path
                         height: 40,
                       ),
                       const SizedBox(width: 10),
                       const Expanded(
                         child: Text(
                           'What is the IDDSI?',
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Color(0xFF01224F), // Dark blue color from level_details.dart
                           ),
                         ),
                       ),
                        const Spacer(), // Pushes the arrow to the right
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Color(0xFF01224F)), // Use arrow back icon
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                     ],
                   ),
                  const SizedBox(height: 20),
                  // IDDSI explanation text
                  const Text(
                    'IDDSI stands for The International Diet Standardisation\nInitiative. It is an organisation that has been created\nto develop a standard and universally recognised way\nto describe different foods and drinks.\n\nIt was created especially for people who have\nswallowing difficulties. The initiative aims to help\npeople better understand what food and drink they are\nable to have as recommended by their healthcare\nprovider. It allows foods and drinks to be catergorised\ninto 8 levels. With the help of healthcare workers,\nspecifically a Speech Therapist, patients are able to\nclearly understand what levels of food and drink they\ncan safely swallow and how to test that the food and\ndrinks they are having correctly matches what has\nbeen recommended for them. Using this system and\nensuring their food is the correct consistency may help\nreduce symptoms and risks of swallowing difficulties.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 