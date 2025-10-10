import 'package:flutter/material.dart';

class Welcome2 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const Welcome2({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // Added to capture all gestures
        onTap: onNext,
        // Added swipe navigation
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! > 0) {
              onPrevious(); // Swipe right to go to previous page (Welcome1)
            } else if (details.primaryVelocity! < 0) {
              onNext(); // Swipe left to go to next page (Welcome3)
            }
          }
        },
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/background2.png',
                fit: BoxFit.cover,
              ),
            ),
            // Content Column
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Main IDDSI image in the middle
                    Image.asset(
                      'assets/images/iddsi_new.png',
                      height: 250, // Increased size
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Welcome To',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF01224F),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Large "iddsi" text logo
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'id',
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0175BC),
                          ),
                        ),
                        Text(
                          'dsi',
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4BB2E3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'International Dysphagia Diet Standardisation Initiative',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF01224F),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'South Africa',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF01224F),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    const Text(
                      'Powered By',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF01224F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Bottom logos row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // IDDSI Logo
                          Image.asset(
                            'assets/iddsi-logo.png',
                            height: 70,
                          ),
                          const SizedBox(width: 40),
                          // Speech Logo
                          Image.asset(
                            'assets/speech.logo.png',
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}