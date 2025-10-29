import 'package:flutter/material.dart';
import 'package:dysphagia_care_app/level_details.dart'; // Corrected import path

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomGradientAppBar(
        levelText: '', // No level text for this page
        titleText: 'Disclaimer',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Disclaimer information will go here.',
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