import 'package:flutter/material.dart';
import 'package:iddsi_app/level_details.dart'; // Corrected import path

class SignsSymptomsPage extends StatelessWidget {
  const SignsSymptomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomGradientAppBar(
        levelText: '', // No level text for this page
        titleText: 'Signs and Symptoms',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Information about Signs and Symptoms will go here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              // You can add an image or other widgets here later
            ],
          ),
        ),
      ),
    );
  }
} 