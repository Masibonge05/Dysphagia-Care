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
                    const Text(
                      'Welcome To',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF01224F),
                      ),
                    ),
                    // Negative spacing to pull image closer
                    Transform.translate(
                      offset: const Offset(0, -20), // Pull up by 20 pixels
                      child: Image.asset(
                        'assets/images/dysphagia_care2.png',
                        height: 300,
                      ),
                    ),

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
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 40),
                          // Speech Logo - Increased size from 70 to 120
                          Image.asset(
                            'assets/speech.logo.png',
                            height: 120,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
